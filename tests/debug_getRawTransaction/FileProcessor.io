
FileProcessor := Object clone do(
    readFile := method(path,
        File with(path) openForReading contents
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
    )
    
    countLines := method(path,
        content := self readFile(path)
        if(content isNil, return 0)
        content split("\n") size
    )
    
    processFile := method(inputPath, outputPath,
        content := self readFile(inputPath)
        if(content isNil, return nil)
        lines := content split("\n")
        processed := lines map(line, "Processed: " .. line) join("\n")
        self writeFile(outputPath, processed)
        lines size
    )
)