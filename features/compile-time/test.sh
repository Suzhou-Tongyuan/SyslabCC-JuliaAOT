# check os
if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    echo "The compiler does not run on macOS."
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    scc compile-time.jl -o libpredict.so --bundle --experimental-gen-header
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # Do something under Windows NT platform
    scc compile-time.jl -o libpredict.dll --bundle --experimental-gen-header
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

gcc -o main main.c -L. -lpredict
./main
