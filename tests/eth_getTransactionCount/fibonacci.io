
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        memo hasKey(i) ifFalse(
            memo atPut(i, fib(i-1) + fib(i-2))
        )
        memo at(i)
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
fib := method(n,
    if(n <= 1, return n)
    return fib(n-1) + fib(n-2)
)

for(i, 0, 9,
    fib(i) println
)