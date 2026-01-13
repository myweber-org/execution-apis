
FileProcessor := Object clone do(
    countLines := method(path,
        file := File with(path) openForReading
        lines := file readLines size
        file close
        lines
    )
    
    wordFrequency := method(path,
        file := File with(path) openForReading
        content := file readContents
        file close
        
        words := content asLowercase split(" ", "\\W+") select(size > 0)
        frequency := Map clone
        words foreach(word,
            frequency atPut(word, frequency at(word) ifNilEval(0) + 1)
        )
        frequency
    )
    
    processFile := method(path,
        lines := self countLines(path)
        freq := self wordFrequency(path)
        topWords := freq keys sortBy(key, freq at(key)) reverse slice(0, 4)
        
        result := Map clone
        result atPut("path", path)
        result atPut("totalLines", lines)
        result atPut("totalWords", freq size)
        result atPut("topWords", topWords map(word, list(word, freq at(word))))
        result
    )
)