
FileProcessor := Object clone do(
    cache := Map clone

    loadFile := method(path,
        cache atIfAbsentPut(path,
            File with(path) openForReading contents
        )
    )

    process := method(path, processor,
        content := loadFile(path)
        processor call(content)
    )

    clearCache := method(
        cache removeAll
    )
)

processor := FileProcessor clone
result := processor process("data.txt", block(content, content split("\n") size))
result println
FileProcessor := Object clone do(
    processFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        content := file openForReading contents
        file close
        
        lines := content split("\n")
        words := content split(" \t\n\r")
        
        wordCount := Map clone
        words foreach(word,
            if(word size > 0,
                wordCount atPut(word, wordCount at(word) ifNilEval(0) + 1)
            )
        )
        
        return Map clone do(
            atPut("lineCount", lines size)
            atPut("wordCount", words size)
            atPut("wordFrequency", wordCount)
        )
    )
    
    printStats := method(stats,
        if(stats isNil, return)
        
        "File Statistics:" println
        ("Total lines: " .. stats at("lineCount")) println
        ("Total words: " .. stats at("wordCount")) println
        
        "\nTop 5 frequent words:" println
        sortedWords := stats at("wordFrequency") asList sortBy(value, value at(1)) reverse
        sortedWords slice(0, 4) foreach(pair,
            ("  " .. pair at(0) .. ": " .. pair at(1)) println
        )
    )
)

// Example usage
if(System args size > 0,
    stats := FileProcessor processFile(System args at(0))
    FileProcessor printStats(stats)
)