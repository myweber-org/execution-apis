
fib := Object clone
fib memo := Map clone
fib generate := method(n,
    if(n <= 1, return n)
    if(fib memo hasKey(n), return fib memo at(n))
    result := fib generate(n - 1) + fib generate(n - 2)
    fib memo atPut(n, result)
    result
)

fibonacciSequence := method(n,
    sequence := List clone
    for(i, 0, n - 1,
        sequence append(fib generate(i))
    )
    sequence
)

result := fibonacciSequence(10)
result foreach(i, v, writeln("Fibonacci[", i, "] = ", v))