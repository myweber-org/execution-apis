
fib := method(n,
    memo := Map withDefault(0)
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo at(k) == 0 and k > 1,
            memo atPut(k, fibRec(k-1) + fibRec(k-2))
        )
        memo at(k)
    )
    
    fibRec(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println