
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

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(n,
        if(memo hasKey(n), return memo at(n))
        result := fib call(n - 1) + fib call(n - 2)
        memo atPut(n, result)
        result
    )
    
    fib call(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
fib := Object clone
fib memo := Map clone

fib calculate := method(n,
    if(n <= 1, return n)
    if(fib memo hasKey(n), return fib memo at(n))
    
    result := fib calculate(n - 1) + fib calculate(n - 2)
    fib memo atPut(n, result)
    result
)

fib printSequence := method(count,
    for(i, 0, count - 1,
        fib calculate(i) print
        if(i < count - 1, ", " print)
    )
    "" println
)

fib printSequence(15)