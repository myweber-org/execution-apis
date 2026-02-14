
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading
            content := file readToEnd
            file close
            content
        ,
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
)

processor := FileProcessor clone
testContent := "Hello, Io World!\nThis is a test file."
processor writeFile("test_output.txt", testContent)
copiedContent := processor readFile("test_output.txt")
("Copied content: " .. copiedContent) println