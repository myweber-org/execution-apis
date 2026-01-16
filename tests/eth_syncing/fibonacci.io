
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(k,
        if(memo hasKey(k),
            memo at(k),
            result := fib(k-1) + fib(k-2)
            memo atPut(k, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci of 10: #{fibonacci(10)}" interpolate println
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

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(x,
        memo at(x) ifNil(
            memo atPut(x, fib(x-1) + fib(x-2))
        )
        memo at(x)
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)