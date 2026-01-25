
fib := Object clone
fib memo := Map clone
fib compute := method(n,
    if (fib memo hasKey(n), return fib memo at(n))
    if (n <= 1, return n)
    result := fib compute(n - 1) + fib compute(n - 2)
    fib memo atPut(n, result)
    result
)

fib compute(10) println
fib compute(20) println
fib compute(30) println