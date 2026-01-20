
fibonacci := method(n,
    if(n <= 1, return n)
    return fibonacci(n - 1) + fibonacci(n - 2)
)

"Fibonacci sequence up to 10:" println
for(i, 0, 10,
    fibonacci(i) println
)
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := block(n,
        if(cache hasKey(n),
            cache at(n),
            result := fib call(n - 1) + fib call(n - 2)
            cache atPut(n, result)
            result
        )
    )
    
    fib call(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)