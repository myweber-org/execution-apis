
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
for(i, 0, 10, 
    fibonacci(i) print
    " " print
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibRec(n-1) + fibRec(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fibRec(n)
)

"Fibonacci numbers:" println
for(i, 0, 10,
    fib(i) println
)