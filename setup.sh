JULIA_PKG_SERVER="https://releases.tongyuan.cc/juliapkg/original" julia --startup-file=no -O0 -e 'using Pkg; pkg"registry rm General";pkg"registry rm Syslab";Pkg.add(string(:TyRandom))'
julia -O0 -e "using Pkg;Pkg.add(string(:TyJuliaCAPI))"
julia -O0 -e "using Pkg;Pkg.add(string(:MethodAnalysis))"