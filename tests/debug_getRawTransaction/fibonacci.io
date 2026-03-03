
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(x,
        if(memo hasKey(x), return memo at(x))
        result := fib(x-1) + fib(x-2)
        memo atPut(x, result)
        result
    )
    
    fib(n)
)

"Fibonacci(10): " print
fibonacci(10) println

"Fibonacci(20): " print
fibonacci(20) println
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibHelper := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibHelper(n-1) + fibHelper(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fibHelper(n)
)

for(i, 0, 10, write(fib(i), " "))
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo hasKey(k),
            memo at(k),
            result := fibRec(k-1) + fibRec(k-2)
            memo atPut(k, result)
            result
        )
    )
    
    fibRec(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := block(n,
        if(memo hasKey(n), return memo at(n))
        result := fibHelper call(n-1) + fibHelper call(n-2)
        memo atPut(n, result)
        result
    )
    
    fibHelper call(n)
)

for(i, 0, 10, write(fib(i), " "))
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibRec(n-1) + fibRec(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fibRec(n)
)

for(i, 0, 10, write("fib(", i, ") = ", fib(i), "\n"))