
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibHelper(n - 1) + fibHelper(n - 2)
        memo atPut(n, result)
        result
    )
    
    fibHelper(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
Fibonacci := Object clone
Fibonacci memo := Map clone

Fibonacci generate := method(n,
    if (memo hasKey(n), return memo at(n))
    if (n <= 1, return n)
    result := generate(n - 1) + generate(n - 2)
    memo atPut(n, result)
    result
)

Fibonacci printSequence := method(count,
    for (i, 0, count - 1,
        generate(i) print
        if (i < count - 1, ", " print)
    )
    "" println
)

Fibonacci printSequence(15)