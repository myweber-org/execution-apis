fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(k,
        if(memo hasKey(k),
            memo at(k),
            result := fibRecursive(k-1) + fibRecursive(k-2)
            memo atPut(k, result)
            result
        )
    )
    
    fibRecursive(n)
)

"Fibonacci of 10: #{fib(10)}" println