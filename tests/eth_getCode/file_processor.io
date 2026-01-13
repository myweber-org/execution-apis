
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