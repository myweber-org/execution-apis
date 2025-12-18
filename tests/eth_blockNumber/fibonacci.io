
fib := method(n,
    if(n < 2, return n)
    fib(n - 1) + fib(n - 2)
)

fib := fib memoized

fib(10) println