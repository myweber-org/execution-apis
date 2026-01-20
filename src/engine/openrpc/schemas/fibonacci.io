
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        memo hasKey(i) ifFalse(
            memo atPut(i, fib(i-1) + fib(i-2))
        )
        memo at(i)
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 1,
    (i .. " : " .. fibonacci(i)) println
)
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibInternal := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibInternal(n - 1) + fibInternal(n - 2)
            cache atPut(n, result)
            result
        )
    )
    
    fibInternal(n)
)

for(i, 0, 10, writeln("fib(", i, ") = ", fib(i)))
fibonacci := method(n,
    if(n <= 1, n, fibonacci(n - 1) + fibonacci(n - 2))
)

for(i, 0, 10,
    fibonacci(i) println
)