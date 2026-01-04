
fibonacci := Object clone
fibonacci memo := Map clone
fibonacci fib := method(n,
    if(n <= 1, return n)
    if(self memo hasKey(n), return self memo at(n))
    result := self fib(n-1) + self fib(n-2)
    self memo atPut(n, result)
    result
)

fibonacci fib(10) println