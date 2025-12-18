
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(x,
        if(cache hasKey(x),
            cache at(x),
            result := fib(x-1) + fib(x-2)
            cache atPut(x, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        memo hasKey(i) ifFalse(
            memo atPut(i, fib(i-1) + fib(i-2))
        )
        memo at(i)
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 1,
    (fibonacci(i) .. " ") print
)
"" println