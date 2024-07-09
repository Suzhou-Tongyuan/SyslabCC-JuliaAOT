scc mandelbrot-singlethread.jl -o build/mandelbrot --no-blas
echo "=============SyslabCC AOT======"
time ./build/mandelbrot 16000 scc-mandelbrot.out.txt

echo "=============Julia============="
time julia mandelbrot-singlethread.jl 16000 jl-mandelbrot.out.txt

echo "=============Julia -t 8==============="
time julia -t 8 mandelbrot-multithread.jl 16000 jl-mandelbrot.out.txt
