
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
        file openForUpdating truncateToSize(0)
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
        if(file exists, file size, 0)
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
        true
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
        true
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists, file size, 0)
    )
)

// Example usage
processor := FileProcessor clone

// Create a test file
testPath := "test_output.txt"
processor writeFile(testPath, "Initial content\n")

// Append additional content
processor appendToFile(testPath, "Appended line\n")

// Read back the content
content := processor readFile(testPath)
content println

// Check file properties
("File exists: " .. processor fileExists(testPath)) println
("File size: " .. processor getFileSize(testPath)) println