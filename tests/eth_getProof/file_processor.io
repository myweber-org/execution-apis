
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
    
    copyFile := method(sourcePath, targetPath,
        content := self readFile(sourcePath)
        self writeFile(targetPath, content)
    )
)

processor := FileProcessor clone
testContent := "Hello, Io World!\nThis is a test file."
processor writeFile("test.txt", testContent)
copiedContent := processor readFile("test.txt")
processor appendToFile("test.txt", "\nAppended line.")
processor copyFile("test.txt", "test_copy.txt")