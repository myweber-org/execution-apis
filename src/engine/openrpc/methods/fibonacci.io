
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := block(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibHelper call(n-1) + fibHelper call(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fibHelper call(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println

"Testing memoization with fib(15):" println
fib(15) println