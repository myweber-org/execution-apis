
FileProcessor := Object clone do(
    cache := Map clone

    loadFile := method(path,
        cache atIfAbsentPut(path,
            File with(path) openForReading contents
        )
    )

    process := method(path, processor,
        content := loadFile(path)
        processor call(content)
    )

    clearCache := method(
        cache removeAll
    )
)

processor := FileProcessor clone
result := processor process("data.txt", block(content, content split("\n") size))
result println