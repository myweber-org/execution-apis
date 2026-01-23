fib := Object clone
fib memo := Map clone
fib generate := method(n,
    if (memo hasKey(n), return memo at(n))
    if (n <= 1, return n)
    result := self generate(n - 1) + self generate(n - 2)
    memo atPut(n, result)
    result
)

fib printSequence := method(n,
    for (i, 0, n,
        self generate(i) print
        if (i < n, ", " print)
    )
    "" println
)

fib printSequence(15)