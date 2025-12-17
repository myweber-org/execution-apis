
fib := method(n,
    if (n <= 1, n, fib(n - 1) + fib(n - 2))
)

for (i, 0, 10,
    fib(i) println
)
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fib(n-1) + fib(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)