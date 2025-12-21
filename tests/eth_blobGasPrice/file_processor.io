
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
        file openForUpdating truncateToSize(0)
        file write(content)
        file close
        content size
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        bytesWritten := file write(content)
        file close
        bytesWritten
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
testPath := "test_output.txt"

if(processor fileExists(testPath) not,
    processor writeFile(testPath, "Initial content\n")
)

processor appendToFile(testPath, "Appended line\n")

fileContent := processor readFile(testPath)
fileSize := processor getFileSize(testPath)

"File content: " println
fileContent println
("File size: " .. fileSize .. " bytes") println
FileProcessor := Object clone do(
    read := method(path,
        file := File with(path) openForReading
        content := file readToEnd
        file close
        content
    )
    
    write := method(path, content,
        file := File with(path) openForUpdating truncateToSize(0)
        file write(content)
        file close
        self
    )
    
    append := method(path, content,
        file := File with(path) openForAppending
        file write(content)
        file close
        self
    )
    
    exists := method(path,
        File exists(path)
    )
    
    size := method(path,
        file := File with(path) openForReading
        size := file size
        file close
        size
    )
)