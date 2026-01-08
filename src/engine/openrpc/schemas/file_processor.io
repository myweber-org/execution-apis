
FileProcessor := Object clone
FileProcessor read := method(path,
    file := File with(path)
    file openForReading
    content := file readToEnd
    file close
    content
)

FileProcessor write := method(path, content,
    file := File with(path)
    file openForUpdating
    file write(content)
    file close
)

FileProcessor append := method(path, content,
    file := File with(path)
    file openForAppending
    file write(content)
    file close
)

FileProcessor exists := method(path,
    File exists(path)
)
FileProcessor := Object clone do(
    read := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents
        ,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
    
    write := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
        content size
    )
    
    append := method(path, content,
        file := File with(path)
        if(file exists not, file create)
        file openForAppending write(content) close
        content size
    )
    
    exists := method(path,
        File with(path) exists
    )
    
    size := method(path,
        file := File with(path)
        if(file exists, file size, 0)
    )
)