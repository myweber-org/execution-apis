
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(x,
        if(memo hasKey(x), 
            memo at(x),
            result := fib(x-1) + fib(x-2)
            memo atPut(x, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 
    (fibonacci(i) asString .. ", ") print
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRecursive(n-1) + fibRecursive(n-2)
        memo atPut(n, result)
        result
    )
    
    fibRecursive(n)
)

"Testing Fibonacci sequence:" println
for(i, 0, 10, 
    (fib(i) asString .. " ") print
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo hasKey(k),
            memo at(k),
            result := fibRec(k-1) + fibRec(k-2)
            memo atPut(k, result)
            result
        )
    )
    
    fibRec(n)
)

"Fibonacci of 10: " print
fib(10) println
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