scc fasta.jl -o build/fasta --no-blas
echo "=============SyslabCC AOT======"
time ./build/fasta 25000000 scc-fast.out.txt

echo "=============Julia============="
time julia fasta.jl 25000000 jl-fast.out.txt

echo "=============GCC==============="
gcc -Wall -O3 fasta.c -o build/fasta-c
time ./build/fasta-c 25000000 >/dev/null
