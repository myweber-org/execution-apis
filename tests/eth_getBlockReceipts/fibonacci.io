
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibHelper(n-1) + fibHelper(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fibHelper(n)
)

for(i, 0, 10, 
    fib(i) println
)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibHelper(n - 1) + fibHelper(n - 2)
        memo atPut(n, result)
        result
    )
    
    fibHelper(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 1,
    (fib(i) asString .. " ") print
)
"" println
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fib(n-1) + fib(n-2)
        memo atPut(n, result)
        result
    )
    
    fib(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println