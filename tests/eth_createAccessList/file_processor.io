
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
        file size
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        if(file exists not, file create)
        file openForAppending write(content) close
        file size
    )
    
    getFileInfo := method(path,
        file := File with(path)
        Map clone atPut("exists", file exists) \
            atPut("size", file size) \
            atPut("path", file path) \
            atPut("modified", file lastDataChangeDate)
    )
)

// Example usage (commented out):
// processor := FileProcessor clone
// content := processor readFile("input.txt")
// newSize := processor writeFile("output.txt", content)
// info := processor getFileInfo("output.txt")
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
        if(file exists,
            file openForAppending write(content) close,
            file openForUpdating write(content) close
        )
        content size
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists,
            file size,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
)