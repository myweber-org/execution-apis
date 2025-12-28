
fib := Object clone
fib memo := Map clone

fib generate := method(n,
    if(n <= 1, return n)
    if(fib memo hasKey(n), return fib memo at(n))
    
    result := fib generate(n - 1) + fib generate(n - 2)
    fib memo atPut(n, result)
    result
)

fib printSequence := method(count,
    for(i, 0, count - 1,
        fib generate(i) print
        if(i < count - 1, ", " print)
    )
    "" println
)

fib printSequence(10)