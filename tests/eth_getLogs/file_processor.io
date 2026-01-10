
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