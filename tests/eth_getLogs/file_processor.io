
FileProcessor := Object clone do(
    read := method(path,
        file := File with(path)
        file openForReading
        content := file readToEnd
        file close
        content
    )
    
    write := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating
        file write(content)
        file close
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
    )
    
    exists := method(path,
        File exists(path)
    )
    
    size := method(path,
        file := File with(path)
        file openForReading
        size := file size
        file close
        size
    )
)
FileProcessor := Object clone do(
    processFile := method(path,
        file := File with(path)
        if(file exists not, return "File not found")
        
        size := file size
        fileType := if(path endsWithSeq(".io"), "Io source", 
                      path endsWithSeq(".txt"), "Text",
                      "Unknown")
        
        "Processed: #{path} | Size: #{size} bytes | Type: #{fileType}" interpolate
    )
    
    validatePath := method(path,
        if(path isNil or path asString isEmpty, 
            return false,
            return path asString beginsWithSeq("/") or path asString containsSeq(":")
        )
    )
)

// Example usage
processor := FileProcessor clone
result := processor processFile("example.txt")
result println
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

    getFileInfo := method(path,
        file := File with(path)
        Map clone atPut("exists", file exists) \
                   atPut("size", file size) \
                   atPut("lastModified", file lastModifiedDate)
    )
)

processor := FileProcessor clone
info := processor getFileInfo("test.txt")
info keys foreach(key, writeln(key, ": ", info at(key)))