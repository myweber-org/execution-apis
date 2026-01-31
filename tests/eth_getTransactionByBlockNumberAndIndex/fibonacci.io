
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
for(i, 0, 10,
    (fibonacci(i) .. " ") print
)
"" println
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibMemo := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibMemo(n-1) + fibMemo(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fibMemo(n)
)

for(i, 0, 10, 
    fib(i) println
)
fib := Object clone
fib memo := Map clone
fib generate := method(n,
    if(n <= 1, return n)
    if(fib memo hasKey(n), return fib memo at(n))
    result := fib generate(n-1) + fib generate(n-2)
    fib memo atPut(n, result)
    result
)

fib generate(10) println
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
for(i, 0, 10, 
    (fibonacci(i) asString .. " ") print
)
"" println