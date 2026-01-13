
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        if(memo hasKey(i), return memo at(i))
        result := fib(i-1) + fib(i-2)
        memo atPut(i, result)
        result
    )
    
    fib(n)
)

"Fibonacci of 10: " print
fibonacci(10) println
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(n,
        if(memo hasKey(n), return memo at(n))
        result := fib call(n - 1) + fib call(n - 2)
        memo atPut(n, result)
        result
    )
    
    fib call(n)
)

"Fibonacci numbers:" println
for(i, 0, 10, 
    (fibonacci(i) asString .. " ") print
)
"" println
fibonacci := method(n,
    memo := Map withDefault(0)
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(k,
        memo at(k) ifNonZeroEval(
            memo atPut(k, fib(k-1) + fib(k-2))
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)