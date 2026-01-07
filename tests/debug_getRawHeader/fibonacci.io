
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(idx,
        if(memo hasKey(idx),
            memo at(idx),
            result := fib call(idx - 1) + fib call(idx - 2)
            memo atPut(idx, result)
            result
        )
    )
    
    fib call(n)
)

"Fibonacci of 10: " print
fibonacci(10) println

"First 15 fibonacci numbers:" println
for(i, 0, 14,
    fibonacci(i) print
    if(i < 14, ", " print)
)
"" println