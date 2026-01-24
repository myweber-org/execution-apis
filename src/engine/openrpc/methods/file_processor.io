
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
        file openForUpdating write(content)
        file close
        content size
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        if(file exists not, file create)
        file openForAppending write(content)
        file close
        content size
    )
    
    getFileInfo := method(path,
        file := File with(path)
        if(file exists not, return nil)
        Map clone atPut("path", file path) \
            atPut("size", file size) \
            atPut("exists", file exists) \
            atPut("isDirectory", file isDirectory)
    )
)