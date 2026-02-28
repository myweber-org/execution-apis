
fib := method(n,
    if(n <= 1, return n)
    fib(n - 1) + fib(n - 2)
)

fib := fib memoized

fib(10) println
fib(20) println
fib(30) println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := block(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibRec call(n - 1) + fibRec call(n - 2)
            memo atPut(n, result)
            result
        )
    )
    
    fibRec call(n)
)

"Fibonacci numbers:" println
for(i, 0, 10,
    (i .. ": ") print
    fib(i) println
)