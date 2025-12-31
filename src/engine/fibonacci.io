
fib := method(n,
    cache := Map withDefault(0)
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRecursive := method(k,
        if(cache hasKey(k) not,
            cache atPut(k, fibRecursive(k-1) + fibRecursive(k-2))
        )
        cache at(k)
    )
    
    fibRecursive(n)
)

0 to(10) foreach(i,
    fib(i) println
)
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
for(i, 0, 10,
    ("F(" .. i .. ") = " .. fibonacci(i)) println
)