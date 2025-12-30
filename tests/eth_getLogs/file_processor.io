
FileProcessor := Object clone do(
    read := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file readToEnd
        file close
        content
    )
    
    write := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating
        file write(content)
        file close
        self
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        self
    )
    
    exists := method(path,
        File with(path) exists
    )
    
    size := method(path,
        file := File with(path)
        if(file exists not, return 0)
        file size
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
        file remove
        file openForUpdating write(content) close
        "Written #{content size} bytes to #{path}" interpolate
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file exists ifFalse(file create)
        file openForAppending write(content) close
        "Appended #{content size} bytes to #{path}" interpolate
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        file exists ifTrue(file size) ifFalse(0)
    )
)

// Example usage
processor := FileProcessor clone

// Check if file exists
path := "test_data.txt"
if(processor fileExists(path) not,
    processor writeFile(path, "Initial content\n")
)

// Append more data
processor appendToFile(path, "Additional data line\n")

// Read and display
content := processor readFile(path)
size := processor getFileSize(path)

"File content: #{content}" interpolate println
"File size: #{size} bytes" interpolate println