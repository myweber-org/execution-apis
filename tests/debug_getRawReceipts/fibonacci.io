
fibonacci := method(n,
    if(n <= 1, n, fibonacci(n - 1) + fibonacci(n - 2))
)

for(i, 0, 10,
    fibonacci(i) println
)
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibInternal := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibInternal(n-1) + fibInternal(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fibInternal(n)
)

"Fibonacci sequence:" println
for(i, 0, 10,
    (fib(i) asString .. " ") print
)
"" println
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(idx,
        if(cache hasKey(idx),
            cache at(idx),
            result := fib(idx - 1) + fib(idx - 2)
            cache atPut(idx, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo hasKey(k),
            memo at(k),
            result := fibRec(k-1) + fibRec(k-2)
            memo atPut(k, result)
            result
        )
    )
    
    fibRec(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 
    fib(i) print
    " " print
)
"" println