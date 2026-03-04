
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
)FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file readToEnd
        file close
        content
    )

    countLines := method(path,
        content := self readFile(path)
        if(content isNil, return 0)
        content split("\n") size
    )

    processFile := method(path,
        lines := self countLines(path)
        if(lines > 0,
            "File '#{path}' contains #{lines} lines" interpolate println,
            "File '#{path}' is empty or doesn't exist" interpolate println
        )
    )
)