
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(k,
        if(memo hasKey(k), return memo at(k))
        result := fib(k-1) + fib(k-2)
        memo atPut(k, result)
        result
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)