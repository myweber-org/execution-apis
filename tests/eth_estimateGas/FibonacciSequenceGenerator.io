
Fibonacci := Object clone
Fibonacci memo := Map clone
Fibonacci generate := method(n,
    if (memo hasKey(n), return memo at(n))
    if (n <= 1, return n)
    result := generate(n - 1) + generate(n - 2)
    memo atPut(n, result)
    result
)

SequencePrinter := Object clone
SequencePrinter printSequence := method(count,
    "Fibonacci sequence:" println
    for(i, 0, count - 1,
        Fibonacci generate(i) print
        if(i < count - 1, ", " print)
    )
    "" println
)

SequencePrinter printSequence(15)