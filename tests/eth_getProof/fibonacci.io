
fibonacci := Object clone do(
    memo := Map clone

    fib := method(n,
        if(memo hasKey(n), return memo at(n))
        if(n <= 1, return n)
        result := fib(n - 1) + fib(n - 2)
        memo atPut(n, result)
        result
    )
)

fibonacci fib(10) println
fibonacci fib(20) println
fibonacci fib(30) println
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

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println
fib := method(n,
    cache := Map clone
    fibMemo := method(n,
        if (cache hasKey(n), return cache at(n))
        result := if (n <= 1, n, fibMemo(n-1) + fibMemo(n-2))
        cache atPut(n, result)
        result
    )
    fibMemo(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println