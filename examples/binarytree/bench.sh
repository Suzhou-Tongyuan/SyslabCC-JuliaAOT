scc bintree.jl -o build/bintree --no-blas
echo "=============SyslabCC AOT======"
time ./build/bintree 21

echo "=============Julia============="
time julia bintree.jl 21

echo "=============GCC==============="
gcc -Wall -O3 bintree.c -o build/bintree-c
time ./build/bintree-c 21
