using Zygote
f(x) = cos(x^2 + 2x - 1) + sin(x^2 - 2x + 1)

function main(argv)
    length(argv) != 1 && error("Usage: amazing-ad <number>")

    x = parse(Float64, argv[1])
    println("x = $x, f'(x) = $(f'(x))")
end

@isdefined(SyslabCC) || main(ARGS) # compat julia entrypoint

@static if @isdefined(SyslabCC)
    SyslabCC.static_compile(
        "f_derivative",
        f',
        (Cdouble, )
    )
end