
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
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path) openForReading
        content := file readToEnd
        file close
        content
    )

    writeFile := method(path, content,
        file := File with(path) openForUpdating
        file write(content)
        file close
    )

    appendToFile := method(path, content,
        file := File with(path) openForAppending
        file write(content)
        file close
    )

    fileExists := method(path,
        File exists(path)
    )

    getFileSize := method(path,
        file := File with(path) openForReading
        size := file size
        file close
        size
    )
)

processor := FileProcessor clone
if(processor fileExists("test.txt"),
    content := processor readFile("test.txt")
    processor writeFile("backup.txt", content)
    processor appendToFile("log.txt", "File processed at: #{Date clone now asString}\n" interpolate)
    "Processed file size: #{processor getFileSize(\"test.txt\")} bytes" interpolate println,
    "File not found" println
)