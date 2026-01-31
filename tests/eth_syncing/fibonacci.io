
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        if(memo hasKey(i), 
            memo at(i),
            result := fib(i-1) + fib(i-2)
            memo atPut(i, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 
    fib := fibonacci(i)
    "#{i}: #{fib}" interpolate println
)
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)

    fibMemo := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibMemo(n - 1) + fibMemo(n - 2)
            cache atPut(n, result)
            result
        )
    )

    fibMemo(n)
)

fib(10) println
fib(15) println
fib(20) println