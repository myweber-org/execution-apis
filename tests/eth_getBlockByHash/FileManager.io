
FileManager := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists, return file contents, return nil)
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating
        file write(content)
        file close
        return file exists
    )
    
    listFiles := method(directory,
        Directory with(directory) fileNames
    )
    
    getFileInfo := method(path,
        file := File with(path)
        if(file exists,
            return Map clone atPut("size", file size) atPut("path", file path) atPut("exists", true),
            return Map clone atPut("exists", false)
        )
    )
)