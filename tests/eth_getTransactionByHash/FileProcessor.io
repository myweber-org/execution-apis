
FileProcessor := Object clone do(
    read := method(path,
        File with(path) openForReading contents
    )
    
    write := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
    )
    
    exists := method(path,
        File with(path) exists
    )
    
    size := method(path,
        File with(path) size
    )
)