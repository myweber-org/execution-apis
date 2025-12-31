
fib := method(n,
    cache := Map withDefault(0)
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRecursive := method(k,
        if(cache hasKey(k) not,
            cache atPut(k, fibRecursive(k-1) + fibRecursive(k-2))
        )
        cache at(k)
    )
    
    fibRecursive(n)
)

0 to(10) foreach(i,
    fib(i) println
)