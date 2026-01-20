
fibonacci := method(n,
    memo := Map withDefault(0)
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(i,
        if(memo hasKey(i) not,
            memo atPut(i, fib call(i-1) + fib call(i-2))
        )
        memo at(i)
    )
    
    fib call(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)