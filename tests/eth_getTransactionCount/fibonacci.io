
fib := method(n,
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

"Fibonacci sequence:" println
for(i, 0, 10, 
    fib(i) print
    " " print
)
"" println