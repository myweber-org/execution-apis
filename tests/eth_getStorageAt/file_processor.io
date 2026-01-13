
FileProcessor := Object clone do(
    countLines := method(path,
        file := File with(path) openForReading
        lines := 0
        file foreachLine(lines = lines + 1)
        file close
        lines
    )
    
    countWords := method(path,
        file := File with(path) openForReading
        content := file readToEnd
        file close
        words := content split(" ") select(w, w size > 0) size
        words
    )
    
    processFile := method(path,
        lines := self countLines(path)
        words := self countWords(path)
        Map clone atPut("path", path) atPut("lines", lines) atPut("words", words)
    )
)

processor := FileProcessor clone
result := processor processFile("sample.txt")
result keys foreach(key,
    value := result at(key)
    ("#{key}: #{value}" interpolate) println
)