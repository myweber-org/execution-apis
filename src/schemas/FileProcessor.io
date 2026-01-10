
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents
        ,
            Exception raise("File not found: " .. path)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
    )
    
    appendFile := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists,
            file size
        ,
            Exception raise("File not found: " .. path)
        )
    )
)