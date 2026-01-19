
fib := method(n,
    if (n <= 1, return n)
    return fib(n - 1) + fib(n - 2)
)

for(i, 0, 9,
    fib(i) println
)