
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
    true
)

FileProcessor append := method(path, content,
    file := File with(path)
    file openForAppending
    file write(content)
    file close
    true
)

FileProcessor exists := method(path,
    File exists(path)
)

FileProcessor copy := method(source, destination,
    content := self read(source)
    self write(destination, content)
)

FileProcessor move := method(source, destination,
    self copy(source, destination)
    File remove(source)
)
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
    
    copyFile := method(sourcePath, targetPath,
        content := self readFile(sourcePath)
        self writeFile(targetPath, content)
    )
)

processor := FileProcessor clone
testContent := "Hello, Io World!\nThis is a test file."
processor writeFile("test_output.txt", testContent)
copiedContent := processor readFile("test_output.txt")
("Copied content: " .. copiedContent) println
FileProcessor := Object clone do(
    readCSV := method(path,
        file := File with(path) openForReading
        lines := file readLines
        file close
        lines map(line, line split(","))
    )
    
    writeCSV := method(data, path,
        file := File with(path) openForUpdating
        data foreach(row,
            line := row join(",")
            file write(line, "\n")
        )
        file close
    )
    
    filterRows := method(data, columnIndex, value,
        data select(row, row at(columnIndex) == value)
    )
    
    getColumn := method(data, columnIndex,
        data map(row, row at(columnIndex))
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
        file openForAppending write(content) close
        "Appended #{content size} bytes to #{path}" interpolate
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

processor appendToFile(testPath, "Additional data\n")
fileContent := processor readFile(testPath)
fileSize := processor getFileSize(testPath)

"File content: #{fileContent}" interpolate println
"File size: #{fileSize} bytes" interpolate println