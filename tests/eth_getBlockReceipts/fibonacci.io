
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        if(memo hasKey(i),
            memo at(i),
            result := fib(i-1) + fib(i-2)
            memo atPut(i, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fib(n-1) + fib(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10,
    (fibonacci(i) .. " ") print
)
"" println
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fib(n-1) + fib(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10,
    (fibonacci(i)) println
)
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(x,
        if(memo hasKey(x),
            memo at(x),
            result := fib(x-1) + fib(x-2)
            memo atPut(x, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence first 10 numbers:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println