
FileProcessor := Object clone do(
    cache := Map clone

    process := method(path,
        if(cache hasKey(path) not,
            cache atPut(path, File with(path) openForReading contents)
        )
        cache at(path)
    )

    clearCache := method(cache empty)
)