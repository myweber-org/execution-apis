
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRecursive := method(n,
        if(cache hasKey(n), return cache at(n))
        result := fibRecursive(n - 1) + fibRecursive(n - 2)
        cache atPut(n, result)
        result
    )
    
    fibRecursive(n)
)

fib(10) println
fib(20) println
fib(30) println