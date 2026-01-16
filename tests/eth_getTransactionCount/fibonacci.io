
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(k,
        if(memo hasKey(k), 
            memo at(k),
            result := fibHelper(k-1) + fibHelper(k-2)
            memo atPut(k, result)
            result
        )
    )
    
    fibHelper(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, 
    fib(i) print
    " " print
)
"" println
fibonacci := method(n,
    if(n <= 1, return n)
    return fibonacci(n - 1) + fibonacci(n - 2)
)

for(i, 0, 10,
    fibonacci(i) println
)
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(i,
        if(cache hasKey(i),
            cache at(i),
            result := fib(i-1) + fib(i-2)
            cache atPut(i, result)
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