
fib := method(n,
    if(n <= 1, n, fib(n - 1) + fib(n - 2))
)

"Fibonacci sequence up to 10:" println
for(i, 0, 10,
    fib(i) println
)