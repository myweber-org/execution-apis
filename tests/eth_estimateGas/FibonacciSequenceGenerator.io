
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
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibHelper(n - 1) + fibHelper(n - 2)
        memo atPut(n, result)
        result
    )
    
    fibHelper(n)
)

"Fibonacci sequence from 0 to 10:" println
for(i, 0, 10,
    fib(i) print
    if(i < 10, ", " print)
)
"" println