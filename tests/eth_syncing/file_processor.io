
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file contents
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
    
    copyFile := method(sourcePath, destPath,
        content := self readFile(sourcePath)
        if(content != nil,
            self writeFile(destPath, content)
        )
        self
    )
)

processor := FileProcessor clone
processor writeFile("test.txt", "Hello, Io!")
content := processor readFile("test.txt")
content println

processor appendToFile("test.txt", "\nAppended text.")
updatedContent := processor readFile("test.txt")
updatedContent println

processor copyFile("test.txt", "test_copy.txt")