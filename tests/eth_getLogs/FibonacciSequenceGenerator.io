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

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println