
fib := Object clone
fib memo := Map clone
fib compute := method(n,
    if (fib memo hasKey(n), return fib memo at(n))
    if (n <= 1, return n)
    result := fib compute(n - 1) + fib compute(n - 2)
    fib memo atPut(n, result)
    result
)

fib compute(10) println
fib compute(20) println
fib compute(30) println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibRec(n-1) + fibRec(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fibRec(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println