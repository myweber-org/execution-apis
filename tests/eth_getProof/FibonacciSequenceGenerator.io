
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

// Generate first 20 Fibonacci numbers
for(i, 0, 19,
    fib(i) println
)fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    generate := method(index,
        if(memo hasKey(index), return memo at(index))
        result := generate(index - 1) + generate(index - 2)
        memo atPut(index, result)
        result
    )
    
    generate(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println