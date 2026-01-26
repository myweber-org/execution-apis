
FileProcessor := Object clone do(
    countLines := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        count := 0
        file foreachLine(line, count = count + 1)
        file close
        count
    )

    filterLines := method(path, pattern,
        file := File with(path)
        if(file exists not, return nil)
        result := List clone
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
        Map clone atPut("totalLines", lines) atPut("filteredLines", filtered)
    )
)