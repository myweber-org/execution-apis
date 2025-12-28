
fib := Object clone
fib memo := Map clone

fib calculate := method(n,
    if (n <= 1, return n)
    if (fib memo hasKey(n), return fib memo at(n))
    
    result := fib calculate(n - 1) + fib calculate(n - 2)
    fib memo atPut(n, result)
    result
)

fib printSequence := method(n,
    for(i, 0, n,
        fib calculate(i) print
        if(i < n, ", " print)
    )
    "" println
)

fib printSequence(10)
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fib(n-1) + fib(n-2)
        memo atPut(n, result)
        result
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)