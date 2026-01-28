
fibonacci := method(n,
    memo := Map with(
        atPut(0, 0),
        atPut(1, 1)
    )
    
    fib := block(n,
        if(memo hasKey(n),
            memo at(n),
            result := fib call(n - 1) + fib call(n - 2)
            memo atPut(n, result)
            result
        )
    )
    
    fib call(n)
)

"Fibonacci sequence first 10:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println