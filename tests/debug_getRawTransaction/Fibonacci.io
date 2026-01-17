
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRecursive := method(n,
        if(cache hasKey(n), return cache at(n))
        result := fibRecursive(n-1) + fibRecursive(n-2)
        cache atPut(n, result)
        result
    )
    
    fibRecursive(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9, fib(i) println)