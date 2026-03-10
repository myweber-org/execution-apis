
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(num,
        if(memo hasKey(num),
            memo at(num),
            result := fibRecursive(num - 1) + fibRecursive(num - 2)
            memo atPut(num, result)
            result
        )
    )
    
    fibRecursive(n)
)

"Fibonacci sequence first 10 numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println