
FileProcessor := Object clone do(
    read := method(path,
        file := File with(path) openForReading
        content := file readToEnd
        file close
        content
    )
    
    write := method(path, content,
        file := File with(path) openForUpdating
        file remove
        file openForAppending
        file write(content)
        file close
    )
    
    append := method(path, content,
        file := File with(path) openForAppending
        file write(content)
        file close
    )
    
    exists := method(path,
        File with(path) exists
    )
)