
fib := method(n,
    if(n <= 1, return n)
    fib(n - 1) + fib(n - 2)
)

fib := fib memoized

"Fibonacci sequence:" println
for(i, 0, 10,
    ("fib(" .. i .. ") = " .. fib(i)) println
)