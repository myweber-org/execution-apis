
fibonacci := method(n,
    memo := Map withDefault(0)
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(i,
        if(memo at(i) == 0,
            memo atPut(i, fib(i-1) + fib(i-2))
        )
        memo at(i)
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
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

"Fibonacci of 10: " print
fibonacci(10) println

"Fibonacci of 15: " print
fibonacci(15) println