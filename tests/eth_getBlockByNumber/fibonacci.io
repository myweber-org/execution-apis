
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    recursive := method(i,
        if(memo hasKey(i), memo at(i),
            result := recursive(i-1) + recursive(i-2)
            memo atPut(i, result)
            result
        )
    )
    
    recursive(n)
)

"Fibonacci of 10: " print
fibonacci(10) println