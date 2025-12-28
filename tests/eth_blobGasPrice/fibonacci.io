
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibRecursive(n - 1) + fibRecursive(n - 2)
            memo atPut(n, result)
            result
        )
    )
    
    fibRecursive(n)
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

"Fibonacci of 10: " print
fibonacci(10) println

"Fibonacci of 20: " print
fibonacci(20) println