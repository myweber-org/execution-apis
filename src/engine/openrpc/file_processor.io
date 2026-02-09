
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