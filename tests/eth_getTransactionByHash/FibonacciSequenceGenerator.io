
FibonacciSequenceGenerator := Object clone do(
    memo := Map clone

    generate := method(n,
        if(memo hasKey(n), return memo at(n))
        if(n <= 1, return n)
        result := generate(n - 1) + generate(n - 2)
        memo atPut(n, result)
        result
    )

    printSequence := method(n,
        for(i, 0, n,
            generate(i) print
            if(i < n, ", " print)
        )
        "" println
    )
)

// Example usage
fib := FibonacciSequenceGenerator clone
fib printSequence(15)