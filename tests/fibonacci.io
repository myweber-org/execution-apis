
fibonacci := Object clone
fibonacci memo := Map clone
fibonacci fib := method(n,
    if(n <= 1, return n)
    if(fibonacci memo hasKey(n), return fibonacci memo at(n))
    result := fibonacci fib(n-1) + fibonacci fib(n-2)
    fibonacci memo atPut(n, result)
    result
)

for(i, 0, 10, fibonacci fib(i) println)