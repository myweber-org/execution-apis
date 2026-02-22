
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(x,
        if(memo hasKey(x),
            memo at(x),
            result := fib(x-1) + fib(x-2)
            memo atPut(x, result)
            result
        )
    )
    
    fib(n)
)

fibonacci(10) println
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    recursive := method(i,
        if(memo hasKey(i), return memo at(i))
        result := recursive(i-1) + recursive(i-2)
        memo atPut(i, result)
        result
    )
    
    recursive(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)