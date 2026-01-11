
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