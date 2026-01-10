
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
        file openForUpdating remove
        file openForAppending write(content)
        file close
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending write(content)
        file close
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists,
            file size,
            nil
        )
    )
)
FileProcessor := Object clone do(
    readLines := method(path, delimiter,
        file := File with(path)
        if(file exists not, return nil)
        content := file openForReading contents
        file close
        if(delimiter, content split(delimiter), content split("\n"))
    )
    
    processLines := method(path, processor, delimiter,
        lines := self readLines(path, delimiter)
        if(lines, lines map(processor))
    )
    
    countWords := method(path,
        self processLines(path,
            block(line, line split(" ") size),
            "\n"
        ) sum
    )
)