
fib := method(n,
    if(n <= 1, return n)
    fib(n - 1) + fib(n - 2)
)

fib := fib memoized

fib(10) println
fib(20) println
fib(30) println