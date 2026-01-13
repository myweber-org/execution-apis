
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(k,
        if(memo hasKey(k),
            memo at(k),
            result := fibHelper(k - 1) + fibHelper(k - 2)
            memo atPut(k, result)
            result
        )
    )
    
    fibHelper(n)
)

for(i, 0, 10, write(fib(i), " "))
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

for(i, 0, 10, fibonacci(i) println)