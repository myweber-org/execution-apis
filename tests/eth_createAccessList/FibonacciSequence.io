
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibHelper(n - 1) + fibHelper(n - 2)
        memo atPut(n, result)
        result
    )
    
    fibHelper(n)
)

for(i, 0, 10, 
    fib(i) println
)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(k,
        if (memo hasKey(k),
            memo at(k),
            result := fibHelper(k - 1) + fibHelper(k - 2)
            memo atPut(k, result)
            result
        )
    )
    
    fibHelper(n)
)

// Generate first 20 Fibonacci numbers
for(i, 0, 19,
    fib(i) println
)