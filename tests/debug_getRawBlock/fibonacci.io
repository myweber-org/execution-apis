
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
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(n,
        if(memo hasKey(n),
            memo at(n),
            result := fib call(n - 1) + fib call(n - 2)
            memo atPut(n, result)
            result
        )
    )
    
    fib call(n)
)

for(i, 0, 10, fibonacci(i) println)