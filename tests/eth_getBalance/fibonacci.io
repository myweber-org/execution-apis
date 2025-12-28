
fibonacci := Object clone
fibonacci cache := Map clone
fibonacci get := method(n,
    if (cache hasKey(n), return cache at(n))
    if (n <= 1, return n)
    result := get(n - 1) + get(n - 2)
    cache atPut(n, result)
    result
)

fibonacci sequence := method(n,
    (0 to(n)) map(i, get(i))
)

fibonacci sequence(10) println