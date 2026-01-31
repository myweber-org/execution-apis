
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file readToEnd
        file close
        content
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating
        file write(content)
        file close
        true
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        true
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists not, return 0)
        file size
    )
)
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
    true
)

FileProcessor append := method(path, content,
    file := File with(path)
    file openForAppending
    file write(content)
    file close
    true
)

FileProcessor exists := method(path,
    File exists(path)
)

FileProcessor remove := method(path,
    File remove(path)
)