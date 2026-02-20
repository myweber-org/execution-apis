
FileProcessor := Object clone do(
    read := method(path,
        file := File with(path)
        if(file exists, return file contents, return nil)
    )
    
    write := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating
        file write(content)
        file close
        return self
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        return self
    )
    
    exists := method(path,
        File with(path) exists
    )
    
    size := method(path,
        file := File with(path)
        if(file exists, return file size, return 0)
    )
)