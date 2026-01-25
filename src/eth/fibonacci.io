
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := block(n,
        if(cache hasKey(n), return cache at(n))
        result := fib call(n - 1) + fib call(n - 2)
        cache atPut(n, result)
        result
    )
    
    fib call(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println