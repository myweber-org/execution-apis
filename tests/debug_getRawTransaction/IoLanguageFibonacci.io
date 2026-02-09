
fib := method(n,
    memo := Map with(
        "0", 0,
        "1", 1
    )
    
    fibRec := method(n,
        if (memo hasKey(n asString),
            memo at(n asString),
            result := fibRec(n - 1) + fibRec(n - 2)
            memo atPut(n asString, result)
            result
        )
    )
    
    fibRec(n)
)

"Fibonacci sequence:" println
for(i, 0, 10,
    fib(i) println
)