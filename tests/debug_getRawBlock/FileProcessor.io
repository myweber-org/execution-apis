
FileProcessor := Object clone do(
    countLines := method(path,
        file := File with(path)
        if(file exists not, return 0)
        file openForReading
        count := 0
        file foreachLine(line, count = count + 1)
        file close
        count
    )

    filterLines := method(path, pattern,
        result := List clone
        file := File with(path)
        if(file exists not, return result)
        file openForReading
        file foreachLine(line,
            if(line contains(pattern),
                result append(line)
            )
        )
        file close
        result
    )

    processFile := method(path, pattern,
        lines := countLines(path)
        filtered := filterLines(path, pattern)
        Map clone atPut("totalLines", lines) atPut("filteredLines", filtered size) atPut("matches", filtered)
    )
)
FileProcessor := Object clone do(
    processFile := method(path,
        file := File with(path) openForReading
        lines := file readLines
        file close

        wordCount := Map clone
        lines foreach(line,
            words := line split
            words foreach(word,
                word = word asLowercase strip
                if(word size > 0,
                    wordCount atPut(word, wordCount at(word) ifNilEval(0) + 1)
                )
            )
        )

        return Map clone do(
            atPut("totalLines", lines size)
            atPut("totalWords", wordCount values sum)
            atPut("wordFrequency", wordCount)
        )
    )

    printStatistics := method(stats,
        "File Statistics:" println
        ("Total lines: " .. stats at("totalLines")) println
        ("Total words: " .. stats at("totalWords")) println
        "\nWord frequency:" println
        stats at("wordFrequency") foreach(word, count,
            (word .. ": " .. count) println
        )
    )
)

// Example usage (commented out):
// stats := FileProcessor processFile("sample.txt")
// FileProcessor printStatistics(stats)