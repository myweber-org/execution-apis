FileProcessor := Object clone do(
    cache := Map clone
    lazyLoad := method(path,
        if(cache hasKey(path) not,
            cache atPut(path, File with(path) openForReading contents)
        )
        cache at(path)
    )
    
    process := method(path,
        content := lazyLoad(path)
        words := content split(" ") select(w, w size > 0)
        words size
    )
    
    clearCache := method(cache removeAll)
)
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