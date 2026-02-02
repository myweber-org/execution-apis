
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := block(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRec call(n-1) + fibRec call(n-2)
        memo atPut(n, result)
        result
    )
    
    fibRec call(n)
)

for(i, 0, 10, 
    fib(i) println
)
fibonacci := method(n,
    if(n <= 1, n, fibonacci(n - 1) + fibonacci(n - 2))
)

for(i, 0, 10,
    fibonacci(i) println
)
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

"Fibonacci sequence:" println
for(i, 0, 10,
    (fibonacci(i) .. " ") print
)
"" println
fib := method(n,
    if(n <= 1, return n)
    return fib(n-1) + fib(n-2)
)

"Fibonacci sequence up to 10:" println
for(i, 0, 10,
    fib(i) println
)