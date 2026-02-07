
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    compute := method(index,
        if(memo hasKey(index), return memo at(index))
        result := compute(index - 1) + compute(index - 2)
        memo atPut(index, result)
        result
    )
    
    compute(n floor)
)

"Testing Fibonacci sequence:" println
for(i, 0, 10, 
    fib(i) println
)