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

"Fibonacci of 10: #{fib(10)}" printlnfib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(k,
        if(memo hasKey(k),
            memo at(k),
            result := fibHelper(k-1) + fibHelper(k-2)
            memo atPut(k, result)
            result
        )
    )
    
    fibHelper(n)
)

"Fibonacci sequence demonstration" println
for(i, 0, 10,
    ("F(" .. i .. ") = " .. fib(i)) println
)