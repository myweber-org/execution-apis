
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRec := method(n,
        if(cache hasKey(n), return cache at(n))
        result := fibRec(n-1) + fibRec(n-2)
        cache atPut(n, result)
        result
    )
    
    fibRec(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibHelper(n-1) + fibHelper(n-2)
        memo atPut(n, result)
        result
    )
    
    fibHelper(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fib(i) println)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := block(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRec call(n - 1) + fibRec call(n - 2)
        memo atPut(n, result)
        result
    )
    
    fibRec call(n)
)

for(i, 0, 10, write(fib(i), " "))