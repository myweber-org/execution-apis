
fibonacci := Object clone do(
    memo := Map clone

    fib := method(n,
        if(memo hasKey(n), return memo at(n))
        if(n <= 1, return n)
        result := fib(n-1) + fib(n-2)
        memo atPut(n, result)
        result
    )
)

fibonacci fib(10) println
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRecursive := method(n,
        if(cache hasKey(n),
            return cache at(n)
        )
        result := fibRecursive(n-1) + fibRecursive(n-2)
        cache atPut(n, result)
        result
    )
    
    fibRecursive(n)
)

for(i, 0, 10, 1,
    fib(i) println
)