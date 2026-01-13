
FileProcessor := Object clone do(
    countLines := method(filePath,
        file := File with(filePath)
        if(file exists not, return 0)
        file openForReading
        count := 0
        file foreachLine(line, count = count + 1)
        file close
        count
    )

    filterLines := method(filePath, pattern,
        result := List clone
        file := File with(filePath)
        if(file exists not, return result)
        file openForReading
        file foreachLine(line,
            if(line contains(pattern),
                result append(line)
            )
        )
        file close
        result
    )

    processFile := method(filePath, pattern,
        lines := countLines(filePath)
        filtered := filterLines(filePath, pattern)
        Map clone atPut("totalLines", lines) atPut("filteredLines", filtered size) atPut("matches", filtered)
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents
        ,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
        true
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
        true
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists, file size, 0)
    )
)

processor := FileProcessor clone
testFile := "test_data.txt"

if(processor fileExists(testFile) not,
    processor writeFile(testFile, "Initial content\n")
)

processor appendToFile(testFile, "Appended line\n")

content := processor readFile(testFile)
writeln("File content: ", content)
writeln("File size: ", processor getFileSize(testFile))