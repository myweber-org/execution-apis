
FileProcessor := Object clone do(
    _cache := Map clone

    load := method(path,
        _cache atIfAbsentPut(path, File with(path) openForReading contents)
    )

    process := method(path, processor,
        content := load(path)
        processor call(content)
    )

    clearCache := method(
        _cache removeAll
    )
)

processor := FileProcessor clone
result := processor process("data.txt", block(content, content asUppercase))
writeln(result)