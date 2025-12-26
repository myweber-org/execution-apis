
FileProcessor := Object clone do(
    countLines := method(path,
        file := File with(path) openForReading
        lines := file readLines size
        file close
        lines
    )
    
    filterLines := method(path, pattern,
        file := File with(path) openForReading
        matchingLines := file readLines select(line, line contains(pattern))
        file close
        matchingLines
    )
    
    processFile := method(path, pattern,
        lines := countLines(path)
        matches := filterLines(path, pattern)
        Map with(
            "totalLines", lines,
            "matchingLines", matches size,
            "matches", matches
        )
    )
)
FileProcessor := Object clone do(
    countLines := method(filePath,
        file := File with(filePath)
        if(file exists not, return nil)
        file openForReading
        count := 0
        file foreachLine(line, count = count + 1)
        file close
        count
    )

    wordFrequency := method(filePath,
        file := File with(filePath)
        if(file exists not, return nil)
        file openForReading
        content := file readToEnd
        file close
        
        words := content asLowercase split(" ", "\t", "\n", "\r", ".", ",", ";", ":", "!", "?", "(", ")", "[", "]", "{", "}", "\"", "'")
        frequency := Map clone
        words foreach(word,
            if(word size > 0,
                frequency atPut(word, frequency at(word) ifNilEval(0) + 1)
            )
        )
        frequency
    )

    processFile := method(filePath,
        lines := self countLines(filePath)
        freq := self wordFrequency(filePath)
        
        if(lines and freq,
            writeln("File: ", filePath)
            writeln("Total lines: ", lines)
            writeln("\nTop 10 frequent words:")
            
            sorted := freq asList sortBy(value, value at(1)) reverse
            sorted slice(0, 9) foreach(pair,
                writeln(pair at(0), ": ", pair at(1))
            )
        ,
            writeln("Error: Could not process file: ", filePath)
        )
    )
)