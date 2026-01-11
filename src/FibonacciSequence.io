
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRecursive(n - 1) + fibRecursive(n - 2)
        memo atPut(n, result)
        result
    )
    
    fibRecursive(n)
)

// Test the implementation
for(i, 0, 10, 
    ("Fibonacci(" .. i .. ") = " .. fib(i)) println
)