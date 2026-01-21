
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo hasKey(k), return memo at(k))
        result := fibRec(k-1) + fibRec(k-2)
        memo atPut(k, result)
        result
    )
    
    fibRec(n)
)

for(i, 0, 10, write(fib(i), " "))
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fib(n-1) + fib(n-2)
        memo atPut(n, result)
        result
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRec(n-1) + fibRec(n-2)
        memo atPut(n, result)
        result
    )
    
    fibRec(n)
)

for(i, 0, 10, write(fib(i), " "))