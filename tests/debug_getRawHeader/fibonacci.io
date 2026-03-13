
fibonacci := Object clone do(
    cache := Map clone

    fib := method(n,
        if(cache hasKey(n), return cache at(n))
        if(n <= 1, return n)
        result := fib(n - 1) + fib(n - 2)
        cache atPut(n, result)
        result
    )
)

"Fibonacci sequence:" println
for(i, 0, 10, fibonacci fib(i) println)