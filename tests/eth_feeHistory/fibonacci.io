
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := block(n,
        if(cache hasKey(n),
            cache at(n),
            result := fib call(n - 1) + fib call(n - 2)
            cache atPut(n, result)
            result
        )
    )
    
    fib call(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRec := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibRec(n-1) + fibRec(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fibRec(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
fib := Object clone
fib memo := Map clone
fib fib := method(n,
    if(n <= 1, return n)
    if(fib memo hasKey(n), return fib memo at(n))
    result := fib fib(n-1) + fib fib(n-2)
    fib memo atPut(n, result)
    result
)

fib fib(10) println
fibonacci := method(n,
    if(n <= 1, return n)
    return fibonacci(n - 1) + fibonacci(n - 2)
)

"Fibonacci sequence (first 10 numbers):" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println