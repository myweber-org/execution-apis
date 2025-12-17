
fibonacci := Object clone do(
    memo := Map clone

    fib := method(n,
        if(memo hasKey(n), return memo at(n))
        if(n <= 1, return n)
        result := fib(n-1) + fib(n-2)
        memo atPut(n, result)
        result
    )
)

fibonacci fib(10) println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRecursive(n - 1) + fibRecursive(n - 2)
        memo atPut(n, result)
        result
    )
    
    fibRecursive(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 
    fib(i) print
    " " print
)
"" println
fib := Object clone
fib memo := Map clone

fib calculate := method(n,
    if (n <= 1, return n)
    if (fib memo hasKey(n), return fib memo at(n))
    
    result := fib calculate(n - 1) + fib calculate(n - 2)
    fib memo atPut(n, result)
    result
)

fib printSequence := method(count,
    for (i, 0, count - 1,
        fib calculate(i) print
        if (i < count - 1, ", " print)
    )
    "" println
)

fib printSequence(15)