# check os
if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    gcc -fPIC -shared -o clib.dylib clib.c
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    gcc -fPIC -shared -o clib.so clib.c
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # Do something under Windows NT platform
    gcc -fPIC -shared -o clib.dll clib.c
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

scc c-interops.jl -o build/c-interops --no-blas
./build/c-interops