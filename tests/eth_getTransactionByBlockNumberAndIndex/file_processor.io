
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
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
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
    )
    
    fileExists := method(path,
        File exists(path)
    )
    
    getFileSize := method(path,
        file := File with(path)
        file size
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file contents
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

    getFileSize := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file size
    )

    copyFile := method(sourcePath, targetPath,
        content := self readFile(sourcePath)
        if(content == nil, return false)
        self writeFile(targetPath, content)
    )
)