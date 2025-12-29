
fib := Object clone
fib memo := Map clone

fib generate := method(n,
    if (n <= 1, return n)
    if (fib memo hasKey(n), return fib memo at(n))
    
    result := fib generate(n - 1) + fib generate(n - 2)
    fib memo atPut(n, result)
    result
)

fib printSequence := method(n,
    for (i, 0, n,
        fib generate(i) print
        if (i < n, ", " print)
    )
    "" println
)

fib printSequence(15)
fibonacci := method(n,
    if(n <= 1, n, fibonacci(n - 1) + fibonacci(n - 2))
)

for(i, 0, 10, fibonacci(i) println)