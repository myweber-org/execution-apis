
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(n,
        if(memo hasKey(n), return memo at(n))
        result := fib call(n - 1) + fib call(n - 2)
        memo atPut(n, result)
        result
    )
    
    fib call(n)
)

"Fibonacci numbers:" println
for(i, 0, 10, 
    (fibonacci(i) asString .. " ") print
)
"" println
fib := Object clone
fib memo := Map clone

fib generate := method(n,
    if (n <= 1, return n)
    if (fib memo hasKey(n), return fib memo at(n))
    
    result := fib generate(n - 1) + fib generate(n - 2)
    fib memo atPut(n, result)
    result
)

fib printSequence := method(count,
    for(i, 0, count - 1,
        fib generate(i) print
        if(i < count - 1, ", " print)
    )
    "" println
)

fib printSequence(15)