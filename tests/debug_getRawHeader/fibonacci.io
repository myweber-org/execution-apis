
fibonacci := Object clone do(
    cache := Map clone

    fib := method(n,
        if(cache hasKey(n), return cache at(n))
        if(n <= 1, return n)
        result := fib(n - 1) + fib(n - 2)
        cache atPut(n, result)
        result
    )
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci fib(i) println)
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

for(i, 0, 10, fibonacci(i) println)