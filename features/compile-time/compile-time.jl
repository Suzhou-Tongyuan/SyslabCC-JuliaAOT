using TyRandom

const RNG = TyRandom.MT19937ar(80)
# This will prompt if neccessary to install everything, including CUDA:
using Flux, CUDA, Statistics, ProgressMeter

# Generate some data for the XOR problem: vectors of length 2, as columns of a matrix:
noisy = rand(RNG, Float32, 2, 1000)                                    # 2×1000 Matrix{Float32}
truth = [xor(col[1]>0.5, col[2]>0.5) for col in eachcol(noisy)]   # 1000-element Vector{Bool}

# Define our model, a multi-layer perceptron with one hidden layer of size 3:
model = Chain(
    Dense(2 => 3, tanh),   # activation function inside layer
    BatchNorm(3),
    Dense(3 => 2)) |> gpu        # move model to GPU, if available

# The model encapsulates parameters, randomly initialised. Its initial output is:
out1 = model(noisy |> gpu) |> cpu                                 # 2×1000 Matrix{Float32}
probs1 = softmax(out1)      # normalise to get probabilities

# To train the model, we use batches of 64 samples, and one-hot encoding:
target = Flux.onehotbatch(truth, [true, false])                   # 2×1000 OneHotMatrix
loader = Flux.DataLoader((noisy, target) |> gpu, batchsize=64, shuffle=true);
# 16-element DataLoader with first element: (2×64 Matrix{Float32}, 2×64 OneHotMatrix)

optim = Flux.setup(Flux.Adam(0.01), model)  # will store optimiser momentum, etc.

# Training loop, using the whole data set 1000 times:
losses = []
@showprogress for epoch in 1:1_000
    for (x, y) in loader
        loss, grads = Flux.withgradient(model) do m
            # Evaluate model and loss inside gradient context:
            y_hat = m(x)
            Flux.logitcrossentropy(y_hat, y)
        end
        Flux.update!(optim, model, grads[1])
        push!(losses, loss)  # logging, outside gradient context
    end
end

optim # parameters, momenta and output have all changed
out2 = model(noisy |> gpu) |> cpu  # first row is prob. of true, second row p(false)
probs2 = softmax(out2)      # normalise to get probabilities
mean((probs2[1,:] .> 0.5) == truth)  # accuracy 94% so far!

const cpu_model = model |> cpu
function predict(poutput::Ptr{Cfloat}, pinput::Ptr{Cfloat}, input_size::Int32)
    input_size = Int(input_size)
    input = unsafe_wrap(Array, pinput, (2, input_size); own=false)
    output = unsafe_wrap(Array, poutput, (2, input_size); own=false)
    try
        output .= cpu_model(input)
        return UInt8(0)
    catch e
        display(e)
        return UInt8(1)
    end
end

@static if @isdefined(SyslabCC)
    SyslabCC.static_compile(
        "predict",
        predict,
        (Ptr{Cfloat}, Ptr{Cfloat}, Int32)
    )
end

println("cpu_model([1.2 3.2 5.2 7.2;2.2 4.2 6.2 8.2]) = ")
println(cpu_model([1.2 3.2 5.2 7.2;2.2 4.2 6.2 8.2]))