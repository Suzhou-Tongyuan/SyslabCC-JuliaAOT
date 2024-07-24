## binarytree

NOTE: this case adopts a few more modifications to the code from the benchmarksgame: we use `mutable struct Node` instead of `struct Node` in this case.

This original code directly adopted from benchmarksgame compiles with SyslabCC, but recursive `struct`s used in this case is not fair in the benchmark: Julia uses recursive structs which has different memory layout from `struct tn*` in the C code.

Our modification to the Julia code is more identical to C: the `Node` itself should be represented as a pointer just like `struct tn*` in C:

```julia
mutable struct Node # a pointer under the hood
    left::Union{Node,Empty} # pointer
    right::Union{Node,Empty} # pointer
end
```

```c
// 'struct tn*' is a pointer
typedef struct tn {
    struct tn*    left; // pointer
    struct tn*    right; // pointer
} treeNode;
```

Without `mutable` keyword, SyslabCC is as efficient as native Julia in the `binarytree` case for the following reasons:

1. SyslabCC introduces a trade-off to avoid GC allocations and boxing for small objects, so `Union` and `Any` can be larger at stack.
2. The size of recursive `struct`s in SyslabCC is the sum of the fields (of course, including natural paddings) which is different from the native Julia.
