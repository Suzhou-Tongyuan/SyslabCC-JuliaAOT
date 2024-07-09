scc nqueen.jl -o build/nqueen --no-blas
echo "=============SyslabCC AOT======"
time ./build/nqueen 15

echo "=============Julia============="
time julia nqueen.jl 15

echo "=============GCC==============="
gcc -Wall -O3 nqueen.c -o build/nqueen-c
time ./build/nqueen-c 15
