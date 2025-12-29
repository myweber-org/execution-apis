
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRec := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibRec(n-1) + fibRec(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fibRec(n)
)

for(i, 0, 10, write(fib(i), " "))
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