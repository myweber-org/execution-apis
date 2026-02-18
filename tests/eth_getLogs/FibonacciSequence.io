
Fibonacci := Object clone do(
    memo := Map clone

    fib := method(n,
        if(memo hasKey(n), return memo at(n))
        if(n <= 1, return n)
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
fibGen := Fibonacci clone
"First 10 Fibonacci numbers:" println
fibGen generateSequence(10) foreach(i, v, v asString println)