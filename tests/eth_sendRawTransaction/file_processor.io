
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