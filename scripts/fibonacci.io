
fibonacci := method(n,
    if(n <= 1, n, fibonacci(n - 1) + fibonacci(n - 2))
)

for(i, 0, 10,
    fibonacci(i) println
)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(k,
        if(memo hasKey(k),
            memo at(k),
            result := fibRec(k - 1) + fibRec(k - 2)
            memo atPut(k, result)
            result
        )
    )
    
    fibRec(n)
)

for(i, 0, 10,
    fib(i) println
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
for(i, 0, 10, fib(i) println)
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibHelper(n-1) + fibHelper(n-2)
            memo atPut(n, result)
            result
        )
    )
    
    fibHelper(n)
)

0 to(10) foreach(i,
    fib(i) println
)
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
fibonacci := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fib := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fib(n-1) + fib(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)
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