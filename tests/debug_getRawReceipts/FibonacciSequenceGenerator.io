FibonacciSequenceGenerator := Object clone do(
    memo := Map clone

    fib := method(n,
        if(memo hasKey(n), return memo at(n))
        if(n <= 1, return n)
        result := fib(n - 1) + fib(n - 2)
        memo atPut(n, result)
        result
    )

    generateSequence := method(count,
        sequence := List clone
        for(i, 0, count - 1,
            sequence append(fib(i))
        )
        sequence
    )
)

// Example usage
generator := FibonacciSequenceGenerator clone
"First 10 Fibonacci numbers:" println
generator generateSequence(10) foreach(i, v, v asString println)