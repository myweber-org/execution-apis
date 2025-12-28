
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    fibRecursive := method(n,
        if(cache hasKey(n),
            cache at(n),
            result := fibRecursive(n-1) + fibRecursive(n-2)
            cache atPut(n, result)
            result
        )
    )
    
    fibRecursive(n)
)

for(i, 0, 10, writeln("fib(", i, ") = ", fib(i)))
fibonacci := Object clone
fibonacci memo := Map clone
fibonacci fib := method(n,
    if(n <= 1, return n)
    if(self memo hasKey(n), return self memo at(n))
    result := self fib(n-1) + self fib(n-2)
    self memo atPut(n, result)
    result
)

for(i, 0, 10, fibonacci fib(i) println)
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
for(i, 0, 10,
    (fibonacci(i) asString .. " ") print
)
"" println