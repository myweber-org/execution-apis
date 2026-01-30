
FileProcessor := Object clone do(
    read := method(path,
        file := File with(path)
        file openForReading
        content := file readToEnd
        file close
        content
    )
    
    write := method(path, content,
        file := File with(path)
        file openForUpdating
        file write(content)
        file close
        true
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        true
    )
    
    exists := method(path,
        File exists(path)
    )
    
    size := method(path,
        file := File with(path)
        file openForReading
        size := file size
        file close
        size
    )
)
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
        file openForUpdating
        file write(content)
        file close
        content size
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        content size
    )
    
    copyFile := method(source, destination,
        content := self readFile(source)
        self writeFile(destination, content)
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
testPath := "test_output.txt"

if(processor fileExists(testPath) not,
    processor writeFile(testPath, "Initial content\n")
    processor appendToFile(testPath, "Appended line\n")
    fileSize := processor getFileSize(testPath)
    ("File created with size: " .. fileSize) println
)

content := processor readFile(testPath)
("File content:\n" .. content) println