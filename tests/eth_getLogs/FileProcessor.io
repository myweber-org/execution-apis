
FileProcessor := Object clone do(
    countLines := method(path,
        file := File with(path)
        if(file exists not, return 0)
        file openForReading
        lines := file readLines size
        file close
        lines
    )
    
    filterLines := method(path, pattern,
        file := File with(path)
        if(file exists not, return list())
        file openForReading
        filtered := file readLines select(line, line contains(pattern))
        file close
        filtered
    )
    
    processFile := method(path, pattern,
        lines := countLines(path)
        filtered := filterLines(path, pattern)
        Map clone atPut("totalLines", lines) atPut("matchingLines", filtered size) atPut("matches", filtered)
    )
)

processor := FileProcessor clone
result := processor processFile("data.txt", "error")
result keys foreach(key, writeln(key, ": ", result at(key)))