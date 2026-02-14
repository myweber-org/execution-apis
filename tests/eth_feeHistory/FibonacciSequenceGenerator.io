
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
FibonacciSequenceGenerator := Object clone do(
    memo := Map clone

    generate := method(n,
        if(memo hasKey(n), return memo at(n))
        if(n <= 1, return n)
        result := generate(n - 1) + generate(n - 2)
        memo atPut(n, result)
        result
    )

    generateSequence := method(count,
        sequence := List clone
        for(i, 0, count - 1,
            sequence append(generate(i))
        )
        sequence
    )
)

// Example usage
fib := FibonacciSequenceGenerator clone
fib generateSequence(15) println