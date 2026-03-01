
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
FileProcessor := Object clone do(
    readFile := method(path,
        try(
            File with(path) openForReading contents
        ) catch(Exception,
            writeln("Error reading file: ", path)
            nil
        )
    )
    
    writeFile := method(path, content,
        try(
            file := File with(path) openForUpdating
            file write(content)
            file close
            true
        ) catch(Exception,
            writeln("Error writing to file: ", path)
            false
        )
    )
    
    appendToFile := method(path, content,
        try(
            file := File with(path) openForAppending
            file write(content)
            file close
            true
        ) catch(Exception,
            writeln("Error appending to file: ", path)
            false
        )
    )
)