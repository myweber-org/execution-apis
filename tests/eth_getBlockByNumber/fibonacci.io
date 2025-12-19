
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(i,
        if(cache hasKey(i), return cache at(i))
        result := fib(i-1) + fib(i-2)
        cache atPut(i, result)
        result
    )
    
    fib(n)
)

"Fibonacci sequence first 10 terms:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println