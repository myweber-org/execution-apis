
Fibonacci := Object clone
Fibonacci memo := Map clone

Fibonacci generate := method(n,
    if (memo hasKey(n), return memo at(n))
    if (n <= 1, return n)
    result := generate(n - 1) + generate(n - 2)
    memo atPut(n, result)
    result
)

Fibonacci printSequence := method(count,
    for (i, 0, count - 1,
        generate(i) print
        if (i < count - 1, ", " print)
    )
    "" println
)fib := Object clone
fib memo := Map clone
fib generate := method(n,
    if (fib memo hasKey(n), return fib memo at(n))
    if (n <= 1, return n)
    result := fib generate(n - 1) + fib generate(n - 2)
    fib memo atPut(n, result)
    result
)

fib printSequence := method(n,
    for(i, 0, n,
        fib generate(i) print
        if(i < n, " " print)
    )
    "" println
)

fib printSequence(10)
Fibonacci := Object clone do(
    memo := Map clone

    fib := method(n,
        if(memo hasKey(n), return memo at(n))
        if(n <= 1, return n)
        result := fib(n-1) + fib(n-2)
        memo atPut(n, result)
        result
    )

    generate := method(count,
        result := List clone
        for(i, 0, count-1, 1,
            result append(fib(i))
        )
        result
    )
)

sequence := Fibonacci generate(10)
sequence foreach(i, v, writeln("Fibonacci[", i, "] = ", v))