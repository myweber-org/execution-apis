
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRec := method(n,
        if(cache hasKey(n), return cache at(n))
        result := fibRec(n-1) + fibRec(n-2)
        cache atPut(n, result)
        result
    )
    
    fibRec(n)
)

for(i, 0, 10, 
    fib(i) println
)