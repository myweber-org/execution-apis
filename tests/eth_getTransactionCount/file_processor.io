
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
        file openForUpdating
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
        File exists(path)
    )
    
    getFileSize := method(path,
        file := File with(path)
        file size
    )
)

processor := FileProcessor clone
if(processor fileExists("test.txt") not,
    processor writeFile("test.txt", "Initial content\n")
)

processor appendToFile("test.txt", "Appended line\n")
fileContent := processor readFile("test.txt")
fileSize := processor getFileSize("test.txt")

("File content: " .. fileContent) println
("File size: " .. fileSize .. " bytes") println