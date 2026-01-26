
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo hasKey(k),
            memo at(k),
            result := fibRec(k-1) + fibRec(k-2)
            memo atPut(k, result)
            result
        )
    )
    
    fibRec(n)
)

for(i, 0, 10, 
    fib(i) println
)
fib := method(n,
    if (n <= 1, return n)
    return fib(n - 1) + fib(n - 2)
)

fib(10) println