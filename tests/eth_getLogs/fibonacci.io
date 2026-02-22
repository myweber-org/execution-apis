
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

for(i, 0, 10, writeln(i, ": ", fib(i)))
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(i,
        if(memo hasKey(i), return memo at(i))
        result := fib call(i - 1) + fib call(i - 2)
        memo atPut(i, result)
        result
    )
    
    fib call(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)