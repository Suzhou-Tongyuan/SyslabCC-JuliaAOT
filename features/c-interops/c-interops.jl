int_func(x) = 2x

function main()
    fptr = @cfunction(int_func, Cdouble, (Cdouble, ))
    data = Cdouble[1.0, 2.0, 3.0]
    GC.@preserve data begin
        value = @ccall "clib".c_sum(
            fptr::Ptr{Cvoid},
            pointer(data)::Ptr{Cdouble},
            length(data)::Int32
        )::Cdouble
    end
    println("final result: ", value)
end

@static @isdefined(SyslabCC) || main()
