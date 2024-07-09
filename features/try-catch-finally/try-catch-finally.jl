using TyRandom
# fix seed for reproducibility
const RNG = TyRandom.MT19937ar(80)

function main()
    tryHit = catchHit = finallyHit = 0
    for i = 1:1000
        try
            rand(RNG) > 0.85 && error("1")
            tryHit += 1
        catch
            catchHit += 1
            try
                rand(RNG) > 0.85 && error("2")
                tryHit += 1
            catch
                catchHit += 1
            finally
                finallyHit + 1
            end
        finally
            finallyHit += 1
        end
    end

    println("tryHit: ", tryHit)
    println("catchHit: ", catchHit)
    println("finallyHit: ", finallyHit)
end

@static @isdefined(SyslabCC) || main()
