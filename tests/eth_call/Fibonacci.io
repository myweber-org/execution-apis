
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := block(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibRec call(n-1) + fibRec call(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fibRec call(n)
)

for(i, 0, 10, write(fib(i), " "))