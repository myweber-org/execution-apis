fib := Object clone
fib cache := Map clone
fib generate := method(n,
    if (cache hasKey(n), return cache at(n))
    if (n <= 1, return n)
    result := generate(n - 1) + generate(n - 2)
    cache atPut(n, result)
    result
)

fib printSequence := method(n,
    for(i, 0, n,
        generate(i) print
        if(i < n, ", " print)
    )
    "" println
)

fib printSequence(15)