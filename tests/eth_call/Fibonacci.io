
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibHelper := method(n,
        if(cache hasKey(n), return cache at(n))
        result := fibHelper(n-1) + fibHelper(n-2)
        cache atPut(n, result)
        result
    )
    
    fibHelper(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibMemo := method(m,
        if(cache hasKey(m),
            cache at(m),
            result := fibMemo(m-1) + fibMemo(m-2)
            cache atPut(m, result)
            result
        )
    )
    
    fibMemo(n)
)

for(i, 0, 10, fib(i) println)