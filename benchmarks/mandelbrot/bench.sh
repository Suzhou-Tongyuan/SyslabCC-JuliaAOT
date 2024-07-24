scc mandelbrot-singlethread.jl -o build/mandelbrot --no-blas
echo "=============SyslabCC AOT======"
time ./build/mandelbrot 16000 scc-mandelbrot.out.txt

echo "=============Julia============="
time julia mandelbrot-singlethread.jl 16000 jl-mandelbrot.out.txt

echo "=============Julia -t 8==============="
time julia -t 8 mandelbrot-multithread.jl 16000 jl-mandelbrot.out.txt

gcc -Wall -O3 mandelbrot-singlethread.c -o ./build/mandelbrot-c
time ./build/mandelbrot-c 16000 c-mandelbrot.out.txt
