
FileProcessor := Object clone do(
    countLines := method(filePath,
        file := File with(filePath) openForReading
        lines := 0
        file foreachLine(line, lines = lines + 1)
        file close
        lines
    )

    countWords := method(filePath,
        file := File with(filePath) openForReading
        words := 0
        file foreachLine(line,
            words = words + (line split size)
        )
        file close
        words
    )

    processFile := method(filePath,
        lines := self countLines(filePath)
        words := self countWords(filePath)
        Map clone atPut("lines", lines) atPut("words", words)
    )
)