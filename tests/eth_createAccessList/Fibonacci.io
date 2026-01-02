
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibMemo := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibMemo(n-1) + fibMemo(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fibMemo(n)
)

"Fibonacci sequence:" println
for(i, 0, 10,
    (fib(i)) println
)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := block(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRec call(n-1) + fibRec call(n-2)
        memo atPut(n, result)
        result
    )
    
    fibRec call(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fib(i) println)