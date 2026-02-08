
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(x,
        if(cache hasKey(x),
            cache at(x),
            result := fib(x-1) + fib(x-2)
            cache atPut(x, result)
            result
        )
    )
    
    fib(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println