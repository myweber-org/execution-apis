
FileProcessor := Object clone do(
    cache := Map clone

    loadFile := method(path,
        cache atIfAbsentPut(path, lazy(
            File with(path) openForReading contents
        ))
    )

    process := method(path, processor,
        content := loadFile(path)
        processor call(content)
    )

    clearCache := method(
        cache removeAll
    )
)