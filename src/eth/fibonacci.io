
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(idx,
        if(memo hasKey(idx), return memo at(idx))
        result := fib call(idx - 1) + fib call(idx - 2)
        memo atPut(idx, result)
        result
    )
    
    fib call(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)