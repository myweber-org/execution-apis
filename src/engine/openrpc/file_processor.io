
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading
            content := file readToEnd
            file close
            content,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
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
    
    copyFile := method(sourcePath, destPath,
        content := self readFile(sourcePath)
        self writeFile(destPath, content)
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists,
            file size,
            nil
        )
    )
)

processor := FileProcessor clone
testFile := "test.txt"

if(processor fileExists(testFile) not,
    processor writeFile(testFile, "Initial content\n")
)

processor appendToFile(testFile, "Appended line\n")

content := processor readFile(testFile)
writeln("File content: ", content)
writeln("File size: ", processor getFileSize(testFile))

processor copyFile(testFile, "test_copy.txt")