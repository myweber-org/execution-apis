
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        memo hasKey(k) ifFalse(
            memo atPut(k, fibRec(k-1) + fibRec(k-2))
        )
        memo at(k)
    )
    
    fibRec(n)
)

"Fibonacci of 10: " print
fib(10) println