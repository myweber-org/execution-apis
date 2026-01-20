
FibonacciSequenceGenerator := Object clone do(
    memo := Map clone

    fib := method(n,
        if (memo hasKey(n), return memo at(n))
        if (n <= 1, return n)
        result := fib(n-1) + fib(n-2)
        memo atPut(n, result)
        result
    )

    generateSequence := method(count,
        sequence := List clone
        for(i, 0, count-1, 1,
            sequence append(fib(i))
        )
        sequence
    )
)

// Example usage
generator := FibonacciSequenceGenerator clone
sequence := generator generateSequence(10)
sequence foreach(i, v, writeln("Fibonacci[", i, "] = ", v))