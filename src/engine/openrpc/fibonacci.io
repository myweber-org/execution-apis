
fibonacci := method(n,
    memo := Map withDefault(0)
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(k,
        memo at(k) ifNonZeroEval(
            memo atPut(k, fib(k-1) + fib(k-2))
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)