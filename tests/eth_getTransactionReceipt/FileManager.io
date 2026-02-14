
FileManager := Object clone do(
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
        "File written successfully"
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        if(file exists,
            file openForAppending write(content) close
            "Content appended"
        ,
            Exception raise("File not found: " .. path)
        )
    )
)