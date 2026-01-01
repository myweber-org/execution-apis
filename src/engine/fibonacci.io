
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
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(x,
        if(memo hasKey(x),
            memo at(x),
            result := fib(x-1) + fib(x-2)
            memo atPut(x, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
Fibonacci := Object clone do(
    memo := Map clone
    
    compute := method(n,
        if(memo hasKey(n), return memo at(n))
        if(n <= 1, return n)
        
        result := compute(n - 1) + compute(n - 2)
        memo atPut(n, result)
        result
    )
)

"Fibonacci sequence:" println
for(i, 0, 10,
    (i .. ": ") print
    Fibonacci compute(i) println
)
fibonacci := method(n,
    if(n <= 1, return n)
    return fibonacci(n - 1) + fibonacci(n - 2)
)

for(i, 0, 10,
    fibonacci(i) println
)