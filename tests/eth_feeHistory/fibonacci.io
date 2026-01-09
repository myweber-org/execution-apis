
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(i,
        if(cache hasKey(i), return cache at(i))
        result := fib(i-1) + fib(i-2)
        cache atPut(i, result)
        result
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
    
    fib := method(i,
        memo hasKey(i) ifFalse(
            memo atPut(i, fib(i-1) + fib(i-2))
        )
        memo at(i)
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)