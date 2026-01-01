
fibonacci := Object clone do(
    memo := Map clone

    fib := method(n,
        if(memo hasKey(n),
            memo at(n),
            if(n <= 1,
                memo atPut(n, n),
                memo atPut(n, fib(n-1) + fib(n-2))
            )
        )
        memo at(n)
    )
)

for(i, 0, 10, fibonacci fib(i) println)