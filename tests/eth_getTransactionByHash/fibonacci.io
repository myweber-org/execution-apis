
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(k,
        if(cache hasKey(k),
            cache at(k),
            result := fib(k-1) + fib(k-2)
            cache atPut(k, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
fibonacci := Object clone
fibonacci cache := Map clone
fibonacci get := method(n,
    if (cache hasKey(n), return cache at(n))
    if (n <= 1, return n)
    result := get(n - 1) + get(n - 2)
    cache atPut(n, result)
    result
)

fibonacci sequence := method(n,
    Range 0 to(n) map(i, get(i))
)

fibonacci sequence(10) println
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

fib(10) println