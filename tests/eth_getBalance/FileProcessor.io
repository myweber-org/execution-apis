
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
        File with(path) exists
    )
    
    size := method(path,
        file := File with(path)
        file size
    )
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
        file openForUpdating write(content)
        file close
        self
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending write(content)
        file close
        self
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
        File with(path) exists
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file openForUpdating truncateToSize(0)
        file write(content)
        file close
        "Written #{content size} bytes to #{path}" interpolate
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        if(file exists not, file create)
        file openForAppending
        file write(content)
        file close
        "Appended #{content size} bytes to #{path}" interpolate
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists, file size, 0)
    )
)