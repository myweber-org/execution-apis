
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibMemo := method(n,
        if(cache hasKey(n), return cache at(n))
        result := fibMemo(n-1) + fibMemo(n-2)
        cache atPut(n, result)
        result
    )
    
    fibMemo(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
fibonacci := method(n,
    memo := Map with(
        "0", 0,
        "1", 1
    )
    
    fib := block(n,
        if (memo hasKey(n asString) not,
            memo atPut(n asString, fib call(n - 1) + fib call(n - 2))
        )
        memo at(n asString)
    )
    
    fib call(n)
)

"Fibonacci sequence:" println
for(i, 0, 10,
    (fibonacci(i) .. " ") print
)
"" println