
fib := method(n,
    cache := Map withDefault(0)
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    compute := method(i,
        if(cache hasKey(i) not,
            cache atPut(i, compute(i-1) + compute(i-2))
        )
        cache at(i)
    )
    
    compute(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fib(i) println)