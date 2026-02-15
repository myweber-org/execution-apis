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
        linesCount := self countLines(path)
        matchingLines := self filterLines(path, pattern)
        Map with(
            "totalLines", linesCount,
            "matchingLines", matchingLines,
            "matchCount", matchingLines size
        )
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents
        ,
            Exception raise("File not found: #{path}" interpolate)
        )
    )

    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
        content
    )

    appendToFile := method(path, content,
        file := File with(path)
        file exists ifFalse(
            file openForUpdating write("") close
        )
        file openForAppending write(content) close
        content
    )

    getFileInfo := method(path,
        file := File with(path)
        Map clone atPut("exists", file exists) \
            atPut("size", file size) \
            atPut("path", file path)
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        File with(path) openForReading contents
    )
    
    writeFile := method(path, content,
        File with(path) openForUpdating write(content) close
    )
    
    countLines := method(path,
        content := readFile(path)
        if(content, content split("\n") size, 0)
    )
    
    process := method(path,
        lines := countLines(path)
        "Processed #{path}: #{lines} lines" interpolate
    )
)