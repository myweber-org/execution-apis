
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(x,
        if(memo hasKey(x),
            memo at(x),
            result := fibRec(x-1) + fibRec(x-2)
            memo atPut(x, result)
            result
        )
    )
    
    fibRec(n)
)

"Fibonacci of 10: " print
fib(10) println