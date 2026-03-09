
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

for(i, 0, 10, writeln("fib(", i, ") = ", fib(i)))
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
for(i, 0, 10, 1,
    fib(i) print
    " " print
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

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println