
FileProcessor := Object clone do(
    countLines := method(filePath,
        file := File with(filePath) openForReading
        lines := file readLines size
        file close
        lines
    )
    
    wordFrequency := method(filePath,
        file := File with(filePath) openForReading
        content := file readLine
        file close
        
        words := content split(" ") map(word, word asLowercase strip)
        frequency := Map clone
        words foreach(word,
            if(word size > 0,
                frequency atPut(word, frequency at(word) ifNil(0) + 1)
            )
        )
        frequency
    )
    
    processFile := method(filePath,
        lines := self countLines(filePath)
        frequency := self wordFrequency(filePath)
        
        result := Map clone
        result atPut("totalLines", lines)
        result atPut("wordFrequency", frequency)
        result
    )
)

processor := FileProcessor clone
result := processor processFile("sample.txt")
result keys foreach(key,
    value := result at(key)
    if(key == "wordFrequency",
        value keys foreach(word,
            ("#{word}: #{value at(word)}" interpolate) println
        ),
        ("#{key}: #{value}" interpolate) println
    )
)