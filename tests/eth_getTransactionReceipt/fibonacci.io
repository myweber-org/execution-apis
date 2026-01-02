
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

"Fibonacci of 10: #{fibonacci(10)}" interpolate println
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        if(memo hasKey(i),
            memo at(i),
            result := fib(i-1) + fib(i-2)
            memo atPut(i, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10,
    fibonacci(i) println
)
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

"Fibonacci sequence:" println
for(i, 0, 10, 
    fib(i) print
    " " print
)
"" println
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

"Fibonacci sequence:" println
for(i, 0, 10,
    fib(i) print
    " " print
)
"" println