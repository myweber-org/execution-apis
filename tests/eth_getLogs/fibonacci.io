
fib := method(n,
    if(n <= 1, n, fib(n - 1) + fib(n - 2))
)

for(i, 0, 10, fib(i) println)
Fibonacci := Object clone do(
    memo := Map clone

    compute := method(n,
        if(memo hasKey(n), return memo at(n))
        if(n <= 1, return n)
        result := compute(n - 1) + compute(n - 2)
        memo atPut(n, result)
        result
    )
)

"Fibonacci sequence:" println
for(i, 0, 10,
    (i .. ": ") print
    Fibonacci compute(i) println
)