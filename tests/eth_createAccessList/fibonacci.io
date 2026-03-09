
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

for(i, 0, 10, writeln("fib(", i, ") = ", fib(i)))
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    compute := method(x,
        if(memo hasKey(x),
            memo at(x),
            result := compute(x-1) + compute(x-2)
            memo atPut(x, result)
            result
        )
    )
    
    compute(n)
)

"Fibonacci sequence demonstration" println
for(i, 0, 10,
    ("fib(" .. i .. ") = " .. fib(i)) println
)