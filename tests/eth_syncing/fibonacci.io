
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRec := method(k,
        if(cache hasKey(k),
            cache at(k),
            result := fibRec(k-1) + fibRec(k-2)
            cache atPut(k, result)
            result
        )
    )
    
    fibRec(n)
)

"Fibonacci numbers:" println
for(i, 0, 10,
    (fib(i) asString .. ", ") print
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRec(n-1) + fibRec(n-2)
        memo atPut(n, result)
        result
    )
    
    fibRec(n)
)

for(i, 0, 10, write(fib(i), " "))
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(k,
        if(memo hasKey(k),
            memo at(k),
            result := fib(k-1) + fib(k-2)
            memo atPut(k, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci of 10: " print
fibonacci(10) println

"Fibonacci of 20: " print
fibonacci(20) println