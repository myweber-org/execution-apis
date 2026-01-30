
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
FileProcessor := Object clone do(
    cache := Map clone

    readFile := method(path,
        if(cache hasKey(path),
            cache at(path),
            content := File with(path) openForReading contents
            cache atPut(path, content)
            content
        )
    )

    process := method(path, processor,
        content := self readFile(path)
        processor call(content)
    )

    clearCache := method(
        cache removeAll
    )
)

processor := FileProcessor clone
result := processor process("data.txt", block(content, content split("\n") size))
result println