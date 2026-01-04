
fibonacci := method(n,
    if(n <= 1, return n)
    return fibonacci(n - 1) + fibonacci(n - 2)
)

"Fibonacci sequence (first 10 numbers):" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(x,
        if(cache hasKey(x), return cache at(x))
        result := fib(x-1) + fib(x-2)
        cache atPut(x, result)
        result
    )
    
    fib(n)
)

"Testing fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)