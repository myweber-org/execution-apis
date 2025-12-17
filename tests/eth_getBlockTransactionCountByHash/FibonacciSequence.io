
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

// Example usage
for(i, 0, 10, 
    fib(i) println
)