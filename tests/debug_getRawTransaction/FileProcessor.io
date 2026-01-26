
FileProcessor := Object clone do(
    countLines := method(filePath,
        file := File with(filePath)
        if(file exists not, return 0)
        file openForReading
        count := 0
        file foreachLine(line, count = count + 1)
        file close
        count
    )

    filterLines := method(filePath, pattern,
        result := List clone
        file := File with(filePath)
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

    processFile := method(filePath, pattern,
        lines := countLines(filePath)
        filtered := filterLines(filePath, pattern)
        Map clone atPut("totalLines", lines) atPut("filteredCount", filtered size) atPut("filteredLines", filtered)
    )
)