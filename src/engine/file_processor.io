
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
        file openForUpdating write(content)
        file close
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending write(content)
        file close
    )
    
    exists := method(path,
        File with(path) exists
    )
    
    size := method(path,
        file := File with(path)
        if(file exists,
            file size
        ,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
)