
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    compute := method(k,
        if(memo hasKey(k), return memo at(k))
        result := compute(k-1) + compute(k-2)
        memo atPut(k, result)
        result
    )
    
    compute(n)
)

"Fibonacci sequence demonstration" println
for(i, 0, 10, 
    ("fibonacci(" .. i .. ") = " .. fibonacci(i)) println
)