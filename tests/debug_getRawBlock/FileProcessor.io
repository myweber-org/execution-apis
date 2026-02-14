
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