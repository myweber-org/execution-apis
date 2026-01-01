
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        if(memo hasKey(i), return memo at(i))
        result := fib(i-1) + fib(i-2)
        memo atPut(i, result)
        result
    )
    
    fib(n)
)

"Fibonacci of 10: " print
fibonacci(10) println

"First 15 fibonacci numbers:" println
for(i, 0, 14,
    fibonacci(i) print
    if(i < 14, ", " print)
)
"" println