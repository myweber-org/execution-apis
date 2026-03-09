
FileProcessor := Object clone do(
    read := method(path,
        File with(path) openForReading contents
    )
    
    write := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
    )
    
    exists := method(path,
        File with(path) exists
    )
    
    size := method(path,
        File with(path) size
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file readToEnd
        file close
        content
    )

    countLines := method(content,
        if(content isNil, return 0)
        content split("\n") size
    )

    wordFrequency := method(content,
        if(content isNil, return Map clone)
        words := content asLowercase split("\\W+") select(word, word size > 0)
        freq := Map clone
        words foreach(word,
            freq atPut(word, freq at(word) ifNilEval(0) + 1)
        )
        freq
    )

    processFile := method(path,
        content := self readFile(path)
        if(content isNil,
            writeln("File not found: ", path)
            return nil
        )

        lines := self countLines(content)
        freq := self wordFrequency(content)

        result := Map clone
        result atPut("path", path)
        result atPut("lines", lines)
        result atPut("wordCount", freq size)
        result atPut("topWords", freq keys sortBy(value, freq at(value)) reverse slice(0, 5))
        result
    )
)

processor := FileProcessor clone
result := processor processFile("sample.txt")
if(result isNil not,
    writeln("Processed: ", result at("path"))
    writeln("Lines: ", result at("lines"))
    writeln("Unique words: ", result at("wordCount"))
    writeln("Top 5 words: ", result at("topWords"))
)