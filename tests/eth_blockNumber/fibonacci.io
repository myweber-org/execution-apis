
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibRecursive(n-1) + fibRecursive(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fibRecursive(n)
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
    
    fibRec := method(k,
        if(cache hasKey(k),
            cache at(k),
            result := fibRec(k-1) + fibRec(k-2)
            cache atPut(k, result)
            result
        )
    )
    
    fibRec(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) println
)