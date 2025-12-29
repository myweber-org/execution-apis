
fibonacci := method(n,
    if (n <= 1, n, fibonacci(n - 1) + fibonacci(n - 2))
)

for (i, 0, 10, 
    fibonacci(i) println
)