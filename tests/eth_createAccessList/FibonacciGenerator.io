
fib := method(n,
    cache := Map clone
    cache atPut(0, 0)
    cache atPut(1, 1)
    
    generate := method(index,
        if(cache hasKey(index), return cache at(index))
        result := generate(index - 1) + generate(index - 2)
        cache atPut(index, result)
        result
    )
    
    generate(n)
)

"First 10 Fibonacci numbers:" println
for(i, 0, 9,
    fib(i) print
    " " print
)
"" println