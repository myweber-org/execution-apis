
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibHelper(n-1) + fibHelper(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fibHelper(n)
)

// Test the implementation
for(i, 0, 10, write("fib(", i, ") = ", fib(i), "\n"))
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

for(i, 0, 10, fibonacci(i) println)