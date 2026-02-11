
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents
        ,
            Exception raise("File not found: " .. path)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
    )
    
    appendFile := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists,
            file size
        ,
            Exception raise("File not found: " .. path)
        )
    )
)
FileProcessor := Object clone do(
    read := method(path,
        File with(path) openForReading contents
    )
    
    write := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
    )
    
    exists := method(path,
        File with(path) exists
    )
    
    size := method(path,
        File with(path) size
    )
)
FileProcessor := Object clone do(
    cache := Map clone

    processFile := method(path,
        if(cache hasKey(path),
            cache at(path),
            content := File with(path) openForReading contents
            cache atPut(path, content)
            content
        )
    )

    clearCache := method(
        cache removeAll
    )

    getCacheSize := method(
        cache size
    )
)

processor := FileProcessor clone
result := processor processFile("data.txt")
processor clearCache