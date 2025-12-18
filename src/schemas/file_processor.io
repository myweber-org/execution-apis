
FileProcessor := Object clone do(
    size := method(path,
        File with(path) size
    )

    lineCount := method(path,
        File with(path) openForReading readLines size
    )

    process := method(path,
        if(File with(path) exists,
            writeln("Processing: ", path)
            writeln("Size: ", self size(path), " bytes")
            writeln("Lines: ", self lineCount(path))
        ,
            writeln("File not found: ", path)
        )
    )
)
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