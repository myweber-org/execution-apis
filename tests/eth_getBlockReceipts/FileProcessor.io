
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
    
    process := method(path, pattern,
        lines := countLines(path)
        filtered := filterLines(path, pattern)
        Map with(
            "totalLines", lines,
            "matchingLines", filtered size,
            "matches", filtered
        )
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        try(
            file := File with(path) openForReading
            content := file contents
            file close
            content
        ) catch(Exception,
            writeln("Error reading file: ", path)
            nil
        )
    )
    
    writeFile := method(path, content,
        try(
            file := File with(path) openForUpdating
            file write(content)
            file close
            true
        ) catch(Exception,
            writeln("Error writing to file: ", path)
            false
        )
    )
    
    appendToFile := method(path, content,
        try(
            file := File with(path) openForAppending
            file write(content)
            file close
            true
        ) catch(Exception,
            writeln("Error appending to file: ", path)
            false
        )
    )
)