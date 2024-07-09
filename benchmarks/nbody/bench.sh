scc nbody.jl -o build/nbody --no-blas
echo "=============SyslabCC AOT======"
time ./build/nbody 50000000

echo "=============Julia============="
time julia nbody.jl 50000000

echo "=============GCC==============="
gcc -Wall -O3 nbody.c -o build/nbody-c
time ./build/nbody-c 50000000
