
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRec := method(x,
        if(memo hasKey(x), return memo at(x))
        result := fibRec(x-1) + fibRec(x-2)
        memo atPut(x, result)
        result
    )
    
    fibRec(n)
)

"Fibonacci of 10: " print
fib(10) println

"Fibonacci of 20: " print
fib(20) println
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fib(n-1) + fib(n-2)
            memo atPut(n, result)
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

for(i, 0, 10, write(fib(i), " "))
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
for(i, 0, 10, fibonacci(i) println)
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

"Testing Fibonacci sequence:" println
for(i, 0, 10, 1,
    (i .. " -> " .. fib(i)) println
)
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := block(idx,
        if(memo hasKey(idx),
            memo at(idx),
            result := fib call(idx - 1) + fib call(idx - 2)
            memo atPut(idx, result)
            result
        )
    )
    
    fib call(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)