
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibHelper(n-1) + fibHelper(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fibHelper(n)
)

"Fibonacci sequence first 10 terms:" println
for(i, 0, 9,
    fib(i) print
    if(i < 9, ", " print)
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibRecursive(n-1) + fibRecursive(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fibRecursive(n)
)

for(i, 0, 10, write(fib(i), " "))
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

// Generate first 20 Fibonacci numbers
for(i, 0, 19,
    fib(i) println
)