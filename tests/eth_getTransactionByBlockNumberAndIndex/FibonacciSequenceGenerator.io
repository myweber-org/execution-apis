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
        if(count < 1, return list())
        sequence := list()
        for(i, 0, count - 1,
            sequence append(fib(i))
        )
        sequence
    )
)

// Example usage
sequence := FibonacciSequenceGenerator generateSequence(10)
sequence foreach(i, v, writeln("Fibonacci[", i, "] = ", v))