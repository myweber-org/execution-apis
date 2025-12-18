
fibonacci := method(n,
    memo := Map withDefault(0)
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(x,
        if(memo at(x) == 0 and x > 1,
            memo atPut(x, fib(x-1) + fib(x-2))
        )
        memo at(x)
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 
    (fibonacci(i) asString .. " ") print
)
"" println
fibonacci := method(n,
    if(n <= 1, n, fibonacci(n - 1) + fibonacci(n - 2))
)

for(i, 0, 10, fibonacci(i) println)