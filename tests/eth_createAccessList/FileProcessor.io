
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