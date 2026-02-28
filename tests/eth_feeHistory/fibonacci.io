
fib := method(n,
    if(n <= 1, n, fib(n - 1) + fib(n - 2))
)

for(i, 0, 10,
    fib(i) println
)
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

"Fibonacci of 10: " print
fib(10) println

"Fibonacci of 20: " print
fib(20) println

"Fibonacci of 30: " print
fib(30) println