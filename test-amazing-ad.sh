echo "===================Running in Julia============================"
echo "time julia amazing-ad.jl 1.2"
time julia amazing-ad.jl 1.2

echo "=============creating executable with SyslabCC================="
scc amazing-ad.jl -o amazing-ad --no-blas # '--no-blas' says not to link with BLAS
echo "time ./amazing-ad 1.2"
time ./amazing-ad 1.2
echo "time ./amazing-ad 1.9"
time ./amazing-ad 1.9

echo "=============creating shared library with SyslabCC=============="

# linux and macos users, you need to
# 1. change DLSUFFIX
# 2. set LD_LIBARY_PATH
DLSUFFIX="dll"
scc amazing-ad.jl -o libamazing-ad.$DLSUFFIX --no-blas --experimental-gen-header
# '--experimental-gen-header' creates 'libamazing-ad.h' file
gcc main.c -L"." -lamazing-ad -o ./amazing-ad-cc
./amazing-ad-cc

rm -f *.dll
rm -f *.exe
rm -f *.so
rm -f *.dylib
rm -f *.a
rm -f *.lib
rm -f *.exe
