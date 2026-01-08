
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(x,
        memo at(x) ifNil(
            memo atPut(x, fib(x-1) + fib(x-2))
        )
        memo at(x)
    )
    
    fib(n)
)

for(i, 0, 10, fibonacci(i) println)