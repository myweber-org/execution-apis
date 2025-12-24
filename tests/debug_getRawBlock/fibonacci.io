
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(x,
        if(cache hasKey(x),
            cache at(x),
            result := fib(x-1) + fib(x-2)
            cache atPut(x, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
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

"Fibonacci of 10: " print
fibonacci(10) println

"Fibonacci of 20: " print
fibonacci(20) println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibHelper(n - 1) + fibHelper(n - 2)
            memo atPut(n, result)
            result
        )
    )
    
    fibHelper(n)
)

for(i, 0, 10, write("fib(", i, ") = ", fibonacci(i), "\n"))
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

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
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

"Fibonacci sequence:" println
for(i, 0, 10, 
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
    return result
)

fibonacci fib(10) println
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(k,
        memo hasKey(k) ifFalse(
            memo atPut(k, fib(k-1) + fib(k-2))
        )
        memo at(k)
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 
    fibonacci(i) print
    " " print
)
"" println
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fib(n-1) + fib(n-2)
        memo atPut(n, result)
        result
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
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
    (fibonacci(i) .. " ") print
)
"" println