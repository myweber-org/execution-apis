
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
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists,
            file size
        ,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
)

processor := FileProcessor clone
testPath := "test_output.txt"

if(processor fileExists(testPath) not,
    processor writeFile(testPath, "Initial content\n")
)

processor appendToFile(testPath, "Appended line\n")

content := processor readFile(testPath)
size := processor getFileSize(testPath)

("File content: " .. content) println
("File size: " .. size .. " bytes") println
FileProcessor := Object clone do(
    maxSize := 1024 * 1024 * 10
    allowedTypes := list("txt", "csv", "json", "xml")
    
    validateFile := method(path,
        if(File exists(path) not, return "File not found")
        
        file := File with(path)
        if(file size > maxSize, return "File too large")
        
        extension := path split(".") last
        if(allowedTypes contains(extension) not, return "Invalid file type")
        
        return "Valid file"
    )
    
    processFile := method(path,
        validation := validateFile(path)
        if(validation != "Valid file", return validation)
        
        file := File with(path)
        content := file openForReading contents
        file close
        
        stats := Map clone
        stats atPut("size", file size)
        stats atPut("lines", content split("\n") size)
        stats atPut("words", content split(" ") size)
        stats atPut("chars", content size)
        
        return stats
    )
)

processor := FileProcessor clone
result := processor processFile("data.txt")
result println