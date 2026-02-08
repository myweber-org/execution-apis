
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(k,
        if(cache hasKey(k),
            cache at(k),
            result := fib(k-1) + fib(k-2)
            cache atPut(k, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)