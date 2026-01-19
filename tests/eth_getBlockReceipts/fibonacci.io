
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(n,
        if(memo hasKey(n), return memo at(n))
        result := fib call(n - 1) + fib call(n - 2)
        memo atPut(n, result)
        result
    )
    
    fib call(n)
)

for(i, 0, 10, fibonacci(i) println)
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(index,
        if(cache hasKey(index),
            cache at(index),
            result := fib(index - 1) + fib(index - 2)
            cache atPut(index, result)
            result
        )
    )
    
    fib(n)
)

for(i, 0, 10, fibonacci(i) println)