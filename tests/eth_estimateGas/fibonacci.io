
fibonacci := method(n,
    if(n == 0, return 0)
    if(n == 1, return 1)
    return fibonacci(n-1) + fibonacci(n-2)
)

for(i, 0, 10,
    fibonacci(i) println
)
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        if(memo hasKey(i),
            memo at(i),
            result := fib(i-1) + fib(i-2)
            memo atPut(i, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)