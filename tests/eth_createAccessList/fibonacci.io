
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRec(n-1) + fibRec(n-2)
        memo atPut(n, result)
        result
    )
    
    fibRec(n)
)

// Test the implementation
0 to(10) foreach(i,
    ("fib(" .. i .. ") = " .. fib(i)) println
)
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
    
    fib := method(x,
        if(memo hasKey(x), return memo at(x))
        result := fib(x-1) + fib(x-2)
        memo atPut(x, result)
        result
    )
    
    fib(n)
)

"Fibonacci of 10: " print
fibonacci(10) println
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

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fibonacci(i) print
    " " print
)
"" println
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRec := method(k,
        if(cache hasKey(k),
            cache at(k),
            result := fibRec(k-1) + fibRec(k-2)
            cache atPut(k, result)
            result
        )
    )
    
    fibRec(n)
)

for(i, 0, 10, fib(i) println)
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

"Fibonacci sequence:" println
for(i, 0, 10,
    fib(i) print
    " " print
)
"" println