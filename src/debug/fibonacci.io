
fibonacci := method(n,
    if(n <= 1, return n)
    return fibonacci(n - 1) + fibonacci(n - 2)
)

fibonacciMemoized := method(n,
    if(n <= 1, return n)
    return fibonacciMemoized(n - 1) + fibonacciMemoized(n - 2)
)

fibonacciMemoized := fibonacciMemoized clone
fibonacciMemoized memoized := true

test := method(
    "Testing standard fibonacci:" println
    for(i, 0, 10, 
        ("fibonacci(" .. i .. ") = " .. fibonacci(i)) println
    )
    
    "\nTesting memoized fibonacci:" println
    for(i, 0, 10,
        ("fibonacciMemoized(" .. i .. ") = " .. fibonacciMemoized(i)) println
    )
    
    "\nPerformance comparison:" println
    startTime := Date secondsToRun(for(i, 0, 30, fibonacci(i)))
    ("Standard (0-30): " .. startTime .. " seconds") println
    
    memoizedTime := Date secondsToRun(for(i, 0, 30, fibonacciMemoized(i)))
    ("Memoized (0-30): " .. memoizedTime .. " seconds") println
)

test
fibonacci := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fib := method(i,
        if(memo hasKey(i),
            memo at(i),
            result := fib(i-1) + fib(i-2)
            memo atPut(i, result)
            result
        )
    )
    
    fib(n)
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci(i) println)