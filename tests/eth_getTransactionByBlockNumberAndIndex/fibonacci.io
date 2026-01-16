
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRecursive := method(num,
        if(cache hasKey(num),
            cache at(num),
            result := fibRecursive(num - 1) + fibRecursive(num - 2)
            cache atPut(num, result)
            result
        )
    )
    
    fibRecursive(n)
)

"Fibonacci sequence from 0 to 10:" println
for(i, 0, 10,
    (fib(i) asString .. ", ") print
)
"" println
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRecursive := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibRecursive(n-1) + fibRecursive(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fibRecursive(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibMemo := method(k,
        if(memo hasKey(k), return memo at(k))
        result := fibMemo(k-1) + fibMemo(k-2)
        memo atPut(k, result)
        result
    )
    
    fibMemo(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fib(i) println)
fibonacci := method(n,
    if (n <= 1, n, fibonacci(n - 1) + fibonacci(n - 2))
)

for (i, 0, 10,
    fibonacci(i) println
)