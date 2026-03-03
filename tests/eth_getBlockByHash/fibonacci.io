
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

for(i, 0, 10, 
    fib(i) println
)
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    compute := method(index,
        if(cache hasKey(index), return cache at(index))
        result := compute(index - 1) + compute(index - 2)
        cache atPut(index, result)
        result
    )
    
    compute(n)
)

for(i, 0, 10, write(fib(i), " "))