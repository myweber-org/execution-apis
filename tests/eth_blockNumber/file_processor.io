
FileProcessor := Object clone do(
    countLines := method(filePath,
        file := File with(filePath) openForReading
        lines := 0
        file foreachLine(line, lines = lines + 1)
        file close
        lines
    )

    countWords := method(filePath,
        file := File with(filePath) openForReading
        content := file readToEnd
        file close
        words := content split(" ") size
        words
    )

    processFile := method(filePath,
        lines := self countLines(filePath)
        words := self countWords(filePath)
        Map clone atPut("lines", lines) atPut("words", words)
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file contents
        file close
        content
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
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
    "File created" println
)

processor appendToFile(testPath, "Appended content\n")

content := processor readFile(testPath)
if(content,
    "File content:" println
    content println
    ("File size: " .. processor getFileSize(testPath) .. " bytes") println
)