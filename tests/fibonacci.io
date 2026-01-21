
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        if(memo hasKey(i), return memo at(i))
        result := fib(i-1) + fib(i-2)
        memo atPut(i, result)
        result
    )
    
    fib(n)
)

"Fibonacci of 10: " print
fibonacci(10) println
fib := method(n,
    if(n <= 1, return n)
    return fib(n-1) + fib(n-2)
)

fib(10) println