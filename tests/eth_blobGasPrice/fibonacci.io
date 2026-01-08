
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(idx,
        if(cache hasKey(idx),
            cache at(idx),
            result := fib(idx - 1) + fib(idx - 2)
            cache atPut(idx, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10,
    (fibonacci(i) asString .. " ") print
)
"" println