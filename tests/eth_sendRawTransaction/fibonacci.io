
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibHelper := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibHelper(n - 1) + fibHelper(n - 2)
            cache atPut(n, result)
            result
        )
    )
    
    fibHelper(n)
)

// Test the implementation
for(i, 0, 10, 
    fib(i) println
)
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(idx,
        if(memo hasKey(idx), return memo at(idx))
        result := fib call(idx - 1) + fib call(idx - 2)
        memo atPut(idx, result)
        result
    )
    
    fib call(n)
)

for(i, 0, 10, fibonacci(i) println)
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fib(n-1) + fib(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)