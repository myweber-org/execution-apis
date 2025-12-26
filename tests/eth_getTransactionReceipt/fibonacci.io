
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(idx,
        if(memo hasKey(idx),
            memo at(idx),
            result := fib call(idx - 1) + fib call(idx - 2)
            memo atPut(idx, result)
            result
        )
    )
    
    fib call(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println
fib := method(n,
    if(n <= 1, n, fib(n - 1) + fib(n - 2))
)

fib(10) println
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

"Fibonacci of 10: " print
fib(10) println

"Fibonacci of 20: " print
fib(20) println