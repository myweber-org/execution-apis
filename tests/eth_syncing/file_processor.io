
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
        file remove
        file openForUpdating write(content) close
        content size
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        if(file exists not, file create)
        file openForAppending write(content) close
        content size
    )
    
    getFileInfo := method(path,
        file := File with(path)
        Map clone atPut("exists", file exists) \
            atPut("size", file size) \
            atPut("path", file path)
    )
)

// Example usage (commented out)
// processor := FileProcessor clone
// processor writeFile("test.txt", "Hello, Io!")
// data := processor readFile("test.txt")
// info := processor getFileInfo("test.txt")