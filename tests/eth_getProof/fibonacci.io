
fib := Object clone
fib memo := Map clone

fib generate := method(n,
    if (fib memo hasKey(n), return fib memo at(n))
    if (n <= 1, return n)
    result := fib generate(n - 1) + fib generate(n - 2)
    fib memo atPut(n, result)
    result
)

fib printSequence := method(n,
    for(i, 0, n,
        fib generate(i) print
        if(i < n, ", " print)
    )
    "" println
)

fib printSequence(15)