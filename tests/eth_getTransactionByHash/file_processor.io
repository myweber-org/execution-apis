
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
        content size
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        if(file exists not, file create)
        file openForAppending write(content) close
        content size
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileInfo := method(path,
        file := File with(path)
        if(file exists,
            Map clone atPut("size", file size) \
                atPut("path", file path) \
                atPut("exists", true)
        ,
            Map clone atPut("exists", false) atPut("path", path)
        )
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
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
    )
    
    appendFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
    )
    
    exists := method(path,
        File exists(path)
    )
    
    size := method(path,
        file := File with(path)
        file size
    )
)

processor := FileProcessor clone
testPath := "test_output.txt"

if(processor exists(testPath) not,
    processor writeFile(testPath, "Initial content\n")
)

processor appendFile(testPath, "Appended line\n")

currentContent := processor readFile(testPath)
fileSize := processor size(testPath)

"File content:" println
currentContent println
("File size: " .. fileSize .. " bytes") println