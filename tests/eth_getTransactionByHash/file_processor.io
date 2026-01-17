
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
        if(file exists not, file create)
        file openForAppending write(content) close
        content size
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileInfo := method(path,
        file := File with(path)
        if(file exists,
            Map clone atPut("size", file size) \
                atPut("path", file path) \
                atPut("exists", true)
        ,
            Map clone atPut("exists", false) atPut("path", path)
        )
    )
)