
FileProcessor := Object clone do(
    countLines := method(filePath,
        file := File with(filePath) openForReading
        lines := 0
        file foreachLine(lines = lines + 1)
        file close
        lines
    )
    
    wordFrequency := method(filePath,
        file := File with(filePath) openForReading
        content := file contents
        file close
        
        words := content asLowercase split(" ", "\t", "\n", "\r", ".", ",", ";", ":", "!", "?", "(", ")", "[", "]", "{", "}", "\"", "'")
        words = words select(word, word size > 0)
        
        frequency := Map clone
        words foreach(word,
            currentCount := frequency at(word) ifNil(0)
            frequency atPut(word, currentCount + 1)
        )
        frequency
    )
    
    processFile := method(filePath,
        lines := self countLines(filePath)
        frequency := self wordFrequency(filePath)
        
        result := Map clone
        result atPut("filePath", filePath)
        result atPut("totalLines", lines)
        result atPut("uniqueWords", frequency size)
        result atPut("wordFrequency", frequency)
        result
    )
)

// Example usage (commented out)
/*
processor := FileProcessor clone
result := processor processFile("sample.txt")
result keys foreach(key,
    value := result at(key)
    if(key == "wordFrequency",
        "Word frequencies:" println
        value keys sort foreach(word,
            count := value at(word)
            ("  " .. word .. ": " .. count) println
        )
    ,
        (key .. ": " .. value) println
    )
)
*/
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents
        ,
            Exception raise("File not found: " .. path)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content)
        file close
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending write(content)
        file close
    )
)

processor := FileProcessor clone
testContent := processor readFile("test.txt")
processor writeFile("output.txt", testContent)
processor appendToFile("log.txt", "Operation completed at: " .. Date now asString .. "\n")