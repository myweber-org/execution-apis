
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents
        ,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
        content size
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file exists ifFalse(
            file openForUpdating write("") close
        )
        file openForAppending write(content) close
        content size
    )
    
    fileSize := method(path,
        file := File with(path)
        file exists ifTrue(file size) ifFalse(0)
    )
)