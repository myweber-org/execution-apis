
fibonacci := method(n,
    if(n <= 1, return n)
    return fibonacci(n - 1) + fibonacci(n - 2)
)

for(i, 0, 10,
    fibonacci(i) println
)
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

"Fibonacci sequence:" println
for(i, 0, 10,
    (fib(i) asString .. ", ") print
)
"" println