
FileProcessor := Object clone do(
    read := method(path,
        file := File with(path)
        if(file exists not, return nil)
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
        self
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        self
    )
    
    exists := method(path,
        File with(path) exists
    )
    
    size := method(path,
        file := File with(path)
        if(file exists not, return 0)
        file size
    )
)