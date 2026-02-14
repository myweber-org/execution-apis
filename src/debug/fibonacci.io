
fibonacci := method(n,
    if(n <= 1, n, fibonacci(n - 1) + fibonacci(n - 2))
)

for(i, 0, 10, fibonacci(i) println)
fibonacci := method(n,
    if (n <= 1, n, fibonacci(n - 1) + fibonacci(n - 2))
)

for (i, 0, 10,
    fibonacci(i) println
)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo hasKey(k), return memo at(k))
        result := fibRec(k-1) + fibRec(k-2)
        memo atPut(k, result)
        result
    )
    
    fibRec(n)
)

"Fibonacci numbers:" println
for(i, 0, 10, fib(i) println)
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRecursive := method(n,
        if(cache hasKey(n),
            return cache at(n)
        )
        result := fibRecursive(n-1) + fibRecursive(n-2)
        cache atPut(n, result)
        result
    )
    
    fibRecursive(n)
)

for(i, 0, 10, 1,
    fib(i) println
)
fibonacci := method(n,
    if(n <= 1, n, fibonacci(n - 1) + fibonacci(n - 2))
)

for(i, 0, 10, fibonacci(i) println)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo hasKey(k), return memo at(k))
        result := fibRec(k-1) + fibRec(k-2)
        memo atPut(k, result)
        result
    )
    
    fibRec(n)
)

"Fibonacci sequence:" println
for(i, 0, 10,
    (fib(i) asString .. " ") print
)
"" println
fibonacci := Object clone
fibonacci memo := Map clone
fibonacci fib := method(n,
    if (n <= 1, return n)
    if (fibonacci memo hasKey(n), return fibonacci memo at(n))
    result := fibonacci fib(n-1) + fibonacci fib(n-2)
    fibonacci memo atPut(n, result)
    result
)

fibonacci fib(10) println