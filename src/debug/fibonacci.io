
fib := method(n,
    if(n <= 1, n, fib(n - 1) + fib(n - 2))
)

for(i, 0, 10,
    fib(i) println
)
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := block(n,
        if(cache hasKey(n), return cache at(n))
        result := fib call(n-1) + fib call(n-2)
        cache atPut(n, result)
        result
    )
    
    fib call(n)
)

for(i, 0, 20, fibonacci(i) println)