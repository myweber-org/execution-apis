
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
        self
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending write(content)
        file close
        self
    )
    
    copyFile := method(sourcePath, targetPath,
        content := self readFile(sourcePath)
        self writeFile(targetPath, content)
    )
)

processor := FileProcessor clone
processor writeFile("test.txt", "Hello, Io!")
processor appendToFile("test.txt", "\nAppended text.")
content := processor readFile("test.txt")
content println