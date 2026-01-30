
fibonacci := Object clone
fibonacci memo := Map clone
fibonacci fib := method(n,
    if (memo hasKey(n), return memo at(n))
    if (n <= 1, return n)
    result := fib(n - 1) + fib(n - 2)
    memo atPut(n, result)
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

"Fibonacci sequence:" println
for(i, 0, 10, fib(i) println)