
fibonacci := method(n,
    if(n <= 1, return n)
    return fibonacci(n - 1) + fibonacci(n - 2)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println