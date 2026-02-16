
FileProcessor := Object clone do(
    getSize := method(path,
        File with(path) size
    )

    getLineCount := method(path,
        File with(path) openForReading readLines size
    )

    processFile := method(path,
        size := self getSize(path)
        lines := self getLineCount(path)
        writeln("File: ", path)
        writeln("Size: ", size, " bytes")
        writeln("Lines: ", lines)
        return list(size, lines)
    )
)
FileProcessor := Object clone do(
    readAndCountLines := method(path,
        file := File with(path)
        if(file exists not, return "File not found: #{path}" interpolate)
        lines := file readLines
        "File '#{path}' has #{lines size} lines" interpolate
    )
)

// Example usage (commented out)
// result := FileProcessor readAndCountLines("example.txt")
// result println
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file readToEnd
        file close
        content
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating
        file write(content)
        file close
        true
    )
    
    countLines := method(path,
        content := self readFile(path)
        if(content == nil, return 0)
        content split("\n") size
    )
    
    processFile := method(inputPath, outputPath,
        content := self readFile(inputPath)
        if(content == nil, return false)
        
        lines := content split("\n")
        processed := lines map(line, "Processed: " .. line) join("\n")
        
        self writeFile(outputPath, processed)
        true
    )
)