
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibHelper(n - 1) + fibHelper(n - 2)
            memo atPut(n, result)
            result
        )
    )
    
    fibHelper(n)
)

"Fibonacci sequence:" println
for(i, 0, 10,
    fib(i) print
    " " print
)
"" println
fib := Object clone
fib memo := Map clone
fib generate := method(n,
    if(n <= 1, return n)
    if(fib memo hasKey(n), return fib memo at(n))
    result := fib generate(n-1) + fib generate(n-2)
    fib memo atPut(n, result)
    result
)

fib generate(10) println
fib := Object clone
fib memo := Map clone
fib generate := method(n,
    if (n <= 1, return n)
    if (fib memo hasKey(n), return fib memo at(n))
    result := fib generate(n - 1) + fib generate(n - 2)
    fib memo atPut(n, result)
    result
)

fib generate(10) println