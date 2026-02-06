
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo hasKey(k), 
            return memo at(k)
        )
        result := fibRec(k-1) + fibRec(k-2)
        memo atPut(k, result)
        result
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
    
    compute := method(n,
        if(cache hasKey(n), return cache at(n))
        result := compute(n-1) + compute(n-2)
        cache atPut(n, result)
        result
    )
    
    compute(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fib(i) println)