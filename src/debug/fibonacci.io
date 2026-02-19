
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRec := method(k,
        if(cache hasKey(k), return cache at(k))
        result := fibRec(k-1) + fibRec(k-2)
        cache atPut(k, result)
        result
    )
    
    fibRec(n)
)

"Fibonacci numbers:" println
for(i, 0, 10, write(fib(i), " "))
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fib(n-1) + fib(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence from 0 to 10:" println
for(i, 0, 10,
    (i .. " -> " .. fibonacci(i)) println
)