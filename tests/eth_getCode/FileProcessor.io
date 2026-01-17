
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
        "Written #{content size} bytes to #{path}" interpolate
    )
    
    processFiles := method(inputPath, outputPath,
        content := self readFile(inputPath)
        processed := content asUppercase
        self writeFile(outputPath, processed)
    )
)FileProcessor := Object clone do(
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
result := processor process("data.txt", block(content, content asUppercase))
result println