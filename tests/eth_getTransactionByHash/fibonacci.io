
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

for(i, 0, 10, fib(i) println)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(k,
        if(memo hasKey(k), return memo at(k))
        result := fibRecursive(k-1) + fibRecursive(k-2)
        memo atPut(k, result)
        result
    )
    
    fibRecursive(n)
)

"Fibonacci of 10: " print
fib(10) println