
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibHelper(n - 1) + fibHelper(n - 2)
            memo atPut(n, result)
            result
        )
    )
    
    fibHelper(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        memo hasKey(i) ifFalse(
            memo atPut(i, fib(i-1) + fib(i-2))
        )
        memo at(i)
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)