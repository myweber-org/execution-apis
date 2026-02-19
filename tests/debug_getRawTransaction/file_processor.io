
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
FileProcessor := Object clone do(
    countLines := method(path,
        file := File with(path) openForReading
        lines := file readLines size
        file close
        lines
    )
    
    countWords := method(path,
        file := File with(path) openForReading
        content := file readAll
        file close
        words := content split(" ") select(w, w size > 0) size
        words
    )
    
    processFile := method(path,
        lines := self countLines(path)
        words := self countWords(path)
        list(lines, words)
    )
    
    printStats := method(path,
        result := self processFile(path)
        "File: #{path}" interpolate println
        "Lines: #{result at(0)}" interpolate println
        "Words: #{result at(1)}" interpolate println
    )
)