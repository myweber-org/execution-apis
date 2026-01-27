
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
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
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
        true
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        true
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists not, return 0)
        file size
    )
)
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
    
    getFileInfo := method(path,
        file := File with(path)
        if(file exists,
            Map clone atPut("path", path) \
                atPut("size", file size) \
                atPut("exists", true) \
                atPut("isDirectory", file isDirectory)
        ,
            Map clone atPut("path", path) atPut("exists", false)
        )
    )
)

// Example usage (commented out):
// processor := FileProcessor clone
// processor writeFile("test.txt", "Hello Io World!")
// result := processor readFile("test.txt")
// result println