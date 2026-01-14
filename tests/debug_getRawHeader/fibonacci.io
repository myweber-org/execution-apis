
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibInternal := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibInternal(n - 1) + fibInternal(n - 2)
            cache atPut(n, result)
            result
        )
    )
    
    fibInternal(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println