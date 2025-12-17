
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(i,
        if(cache hasKey(i),
            cache at(i),
            result := fib(i-1) + fib(i-2)
            cache atPut(i, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRecursive := method(n,
        if(cache hasKey(n), return cache at(n))
        result := fibRecursive(n-1) + fibRecursive(n-2)
        cache atPut(n, result)
        result
    )
    
    fibRecursive(n)
)

for(i, 0, 10, writeln("fib(", i, ") = ", fib(i)))