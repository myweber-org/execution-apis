
FileProcessor := Object clone

FileProcessor read := method(path,
    file := File with(path)
    file openForReading
    content := file readToEnd
    file close
    content
)

FileProcessor write := method(path, content,
    file := File with(path)
    file remove
    file openForUpdating
    file write(content)
    file close
    true
)

FileProcessor append := method(path, content,
    file := File with(path)
    file openForAppending
    file write(content)
    file close
    true
)

FileProcessor exists := method(path,
    File exists(path)
)

FileProcessor copy := method(source, destination,
    content := self read(source)
    self write(destination, content)
)

FileProcessor move := method(source, destination,
    self copy(source, destination)
    File remove(source)
)
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
    
    copyFile := method(sourcePath, targetPath,
        content := self readFile(sourcePath)
        self writeFile(targetPath, content)
    )
)

processor := FileProcessor clone
testContent := "Hello, Io World!\nThis is a test file."
processor writeFile("test_output.txt", testContent)
copiedContent := processor readFile("test_output.txt")
("Copied content: " .. copiedContent) println