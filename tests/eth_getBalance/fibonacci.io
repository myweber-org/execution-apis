
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo hasKey(k), return memo at(k))
        result := fibRec(k-1) + fibRec(k-2)
        memo atPut(k, result)
        result
    )
    
    fibRec(n)
)

"Fibonacci numbers:" println
for(i, 0, 10, 
    (fib(i) asString .. ", ") print
)
"" println
fibonacci := method(n,
    memo := Map withDefault(0)
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(x,
        if(memo at(x) == 0 and x > 1,
            memo atPut(x, fib(x-1) + fib(x-2))
        )
        memo at(x)
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 1,
    (fibonacci(i) asString .. " ") print
)
"" println
fibonacci := Object clone
fibonacci memo := Map clone
fibonacci fib := method(n,
    if(n <= 1, return n)
    if(self memo hasKey(n), return self memo at(n))
    result := self fib(n-1) + self fib(n-2)
    self memo atPut(n, result)
    result
)

fibonacci fib(10) println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo hasKey(k), return memo at(k))
        result := fibRec(k-1) + fibRec(k-2)
        memo atPut(k, result)
        result
    )
    
    fibRec(n)
)

for(i, 0, 10, 
    fib(i) println
)
fib := Object clone
fib memo := Map clone
fib generate := method(n,
    if (n <= 1, return n)
    if (fib memo hasKey(n), return fib memo at(n))
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

fib printSequence(15)