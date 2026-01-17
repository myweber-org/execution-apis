
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRecursive(n - 1) + fibRecursive(n - 2)
        memo atPut(n, result)
        result
    )
    
    fibRecursive(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 
    fib(i) print
    " " print
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRec(n-1) + fibRec(n-2)
        memo atPut(n, result)
        result
    )
    
    fibRec(n)
)

"Fibonacci of 10: " print
fib(10) println
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibInternal := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibInternal(n-1) + fibInternal(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fibInternal(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 1,
    (fib(i) asString .. " ") print
)
"" println