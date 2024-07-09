# SyslabCC: An AOT Compiler for Type-stable Julia Programs

## The Highlighting Example

```julia
# file: amazing-ad.jl
using Zygote
f(x) = cos(x^2 + 2x - 1) + sin(x^2 - 2x + 1)

function main(argv)
    length(argv) != 1 && error("Usage: amazing-ad <number>")

    x = parse(Float64, argv[1])
    println("x = $x, f'(x) = $(f'(x))")
end

@isdefined(SyslabCC) || main(ARGS) # compat julia entrypoint
```

The above program compiles and runs with SyslabCC.

```shell
> time julia amazing-ad.jl 1.2
x = 1.2, f'(x) = -0.9073019030856714

real    0m1.905s
user    0m0.000s
sys     0m0.000s

> scc amazing-ad.jl -o amazing-ad --no-blas
    [...]
> time ./amazing-ad.exe 1.2
x = 1.2, f'(x) = -0.9073019030856714

real    0m0.031s
user    0m0.000s
sys     0m0.000s
```

See `amazing-ad.jl` and `test-amazing-ad.sh` for details.

The generated binaries are standalone and do not require Julia to be installed on the target machine. Above example only links to `libdl`, `libm`, `libpthread`, `libc` and `libbdwgc` on Linux.

`libbdwgc` refers to the Boehm GC and is built from the source of your generated C++ project. SyslabCC always produces a C++ project, the default output location is `$PWD/.syslab-cache/<project-name>`. The code should be portable, you may compile it on any platform with a proper C++ compiler.

## Features

This repo also holds killer features that SyslabCC provides.

You might check the following directories:
1. `features/c-interops`: This example shows full C interoperability. It demonstrates how to call shared libraries and create C callbacks from Julia.

2. `features/compile-time`: This example trains models using Flux.jl & CUDA.jl at compile time, exporting an inference model to C++ code/shared libraries using SyslabCC. The exported C++ code/shared libraries run without requiring a Julia installation, and it is even possible to compile the source again for embedded systems (you may need to provide corresponding artifacts for target platforms).

3. `features/try-catch-finally`: This examples shows an extreme case of using `try`-`catch`-`finally` constructs in both Julia and SyslabCC, evidencing that SyslabCC handles these constructs properly.


## Benchmarks

SyslabCC is designed to be fast. No latency, and as fast as the vanilla Julia code.

You might check the following directories:

- `benchmarks/nbody`
- `benchmarks/binarytree`
- `benchmarks/fasta`
- `benchmarks/mandelbrot`
- `benchmarks/nqueen`

Each directory contains a `bench.sh` which directly runs under Linux or Windows MinGW64 environments, provided you have SyslabCC installed. The benchmarks are derived from the [The Computer Language Benchmarks Game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/). We have slightly modified them by adding entrypoint/main functions.

## Access to SyslabCC

Although SyslabCC is currently a proprietary Julia AOT compiler, you might access it through the following approaches:

1. Contact us to establish a commercial collaboration, if you need to use SyslabCC for commercial products. (Email: support@tongyuan.cc)
2. Applying for a non-commercial license to obtain [MWORKS.Syslab](https://www.tongyuan.cc/release/syslab). SyslabCC is already bundled in the community edition.
