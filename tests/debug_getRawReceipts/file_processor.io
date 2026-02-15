
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
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists, file size, 0)
    )
)

processor := FileProcessor clone
testPath := "test_output.txt"

if(processor fileExists(testPath) not,
    processor writeFile(testPath, "Initial content\n")
)

processor appendToFile(testPath, "Appended line\n")

fileContent := processor readFile(testPath)
fileSize := processor getFileSize(testPath)

("File content: " .. fileContent) println
("File size: " .. fileSize .. " bytes") println
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
        if(file exists not, return 0)
        file size
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

"File size: #{size} bytes" interpolate println
FileProcessor := Object clone
FileProcessor read := method(path,
    file := File with(path)
    file openForReading
    content := file readToEnd
    file close
    content
)

FileProcessor write := method(path, content,
    file := File with(path)
    file remove
    file openForUpdating
    file write(content)
    file close
)

FileProcessor append := method(path, content,
    file := File with(path)
    file openForAppending
    file write(content)
    file close
)

FileProcessor exists := method(path,
    File exists(path)
)

FileProcessor delete := method(path,
    File remove(path)
)