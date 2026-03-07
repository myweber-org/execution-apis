
fib := method(n,
    memo := Map withDefault(0)
    memo atPut(0, 0)
    memo atPut(1, 1)
    
    fibRecursive := method(x,
        if(memo at(x) == 0 and x != 0,
            memo atPut(x, fibRecursive(x-1) + fibRecursive(x-2))
        )
        memo at(x)
    )
    
    fibRecursive(n)
)

for(i, 0, 10, write(fib(i), " "))