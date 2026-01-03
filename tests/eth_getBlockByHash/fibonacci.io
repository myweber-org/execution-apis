
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(n,
        if(memo hasKey(n),
            memo at(n),
            result := fib call(n - 1) + fib call(n - 2)
            memo atPut(n, result)
            result
        )
    )
    
    fib call(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibHelper(n - 1) + fibHelper(n - 2)
        memo atPut(n, result)
        result
    )
    
    fibHelper(n)
)

for(i, 0, 10, write(fib(i), " "))