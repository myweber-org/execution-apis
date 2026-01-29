
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibMemo := method(n,
        if(cache hasKey(n), return cache at(n))
        result := fibMemo(n - 1) + fibMemo(n - 2)
        cache atPut(n, result)
        result
    )
    
    fibMemo(n)
)

for(i, 0, 10, fib(i) println)