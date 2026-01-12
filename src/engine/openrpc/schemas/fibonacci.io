
fib := Object clone
fib memo := Map clone
fib fib := method(n,
    if(n <= 1, return n)
    if(memo hasKey(n), return memo at(n))
    result := fib(n-1) + fib(n-2)
    memo atPut(n, result)
    result
)

fib(10) println
fib(20) println