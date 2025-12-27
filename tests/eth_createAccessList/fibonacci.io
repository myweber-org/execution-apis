
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibHelper := method(n,
        if(cache hasKey(n), return cache at(n))
        result := fibHelper(n - 1) + fibHelper(n - 2)
        cache atPut(n, result)
        result
    )
    
    fibHelper(n)
)

for(i, 0, 10, writeln("fib(", i, ") = ", fib(i)))