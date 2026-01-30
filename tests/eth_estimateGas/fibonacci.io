
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

"Fibonacci sequence:" println
for(i, 0, 10, 
    fib(i) print
    " " print
)
"" println
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

for(i, 0, 10, fibonacci(i) println)