
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
        content size
    )

    appendToFile := method(path, content,
        file := File with(path)
        if(file exists not, file create)
        file openForAppending write(content) close
        content size
    )

    getFileInfo := method(path,
        file := File with(path)
        Map clone atPut("exists", file exists) \
            atPut("size", file size) \
            atPut("path", file path) \
            atPut("modified", file lastDataChangeDate)
    )
)
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
        result := List clone
        file := File with(path)
        if(file exists not, return result)
        file openForReading
        file foreachLine(line,
            if(line contains(pattern), result append(line))
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