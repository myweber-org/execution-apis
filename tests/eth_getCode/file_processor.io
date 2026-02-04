
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
        file openForUpdating write(content)
        file close
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending write(content)
        file close
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
writeln("File size: ", processor getFileSize(testFile), " bytes")
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
        "Written #{content size} bytes to #{path}" interpolate
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        if(file exists not, file create)
        file openForAppending write(content) close
        "Appended #{content size} bytes to #{path}" interpolate
    )
    
    copyFile := method(sourcePath, targetPath,
        content := self readFile(sourcePath)
        self writeFile(targetPath, content)
    )
)

processor := FileProcessor clone
result := processor writeFile("test.txt", "Hello Io World!")
result println

processor appendToFile("test.txt", "\nAnother line added.")
content := processor readFile("test.txt")
content println

processor copyFile("test.txt", "test_copy.txt")
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

// Example usage (commented out)
// processor := FileProcessor clone
// processor writeFile("test.txt", "Hello, Io!")
// data := processor readFile("test.txt")
// data println
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
        lines := filterLines(filePath, pattern)
        count := lines size
        lines foreach(i, line,
            writeln("#{i + 1}: #{line}" interpolate)
        )
        writeln("Found #{count} matching lines" interpolate)
        count
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
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
        self
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        self
    )
    
    fileExists := method(path,
        File exists(path)
    )
    
    getFileSize := method(path,
        file := File with(path)
        file size
    )
)