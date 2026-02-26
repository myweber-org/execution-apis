
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibHelper(n - 1) + fibHelper(n - 2)
        memo atPut(n, result)
        result
    )
    
    fibHelper(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibHelper := method(n,
        if(memo hasKey(n),
            memo at(n),
            result := fibHelper(n - 1) + fibHelper(n - 2)
            memo atPut(n, result)
            result
        )
    )
    
    fibHelper(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRecursive(n - 1) + fibRecursive(n - 2)
        memo atPut(n, result)
        result
    )
    
    fibRecursive(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println
fib := method(n,
    memo := Map clone
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(n,
        if(memo hasKey(n), return memo at(n))
        result := fibRecursive(n-1) + fibRecursive(n-2)
        memo atPut(n, result)
        result
    )
    
    fibRecursive(n)
)

for(i, 0, 10, 
    fib(i) println
)
Fibonacci := Object clone
Fibonacci memo := Map clone
Fibonacci fib := method(n,
    if (memo hasKey(n), return memo at(n))
    if (n <= 1, return n)
    result := fib(n - 1) + fib(n - 2)
    memo atPut(n, result)
    result
)

SequenceGenerator := Object clone
SequenceGenerator generate := method(count,
    result := List clone
    for(i, 0, count - 1,
        result append(Fibonacci fib(i))
    )
    result
)

generator := SequenceGenerator clone
sequence := generator generate(20)
sequence foreach(i, v, writeln("Fibonacci[", i, "] = ", v))