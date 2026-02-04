
FileProcessor := Object clone do(
    readLines := method(path, delimiter,
        file := File with(path) openForReading
        lines := file readToEnd split(delimitor)
        file close
        lines map(line, line strip)
    )
    
    processFile := method(path, delimiter, processor,
        lines := self readLines(path, delimiter)
        lines foreach(i, line,
            result := processor call(line)
            if(result, result println)
        )
    )
)FileProcessor := Object clone do(
    read := method(path,
        File with(path) openForReading contents
    )
    
    write := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
        content
    )
    
    append := method(path, content,
        file := File with(path)
        file exists ifFalse(file openForUpdating close)
        file openForAppending write(content) close
        content
    )
    
    exists := method(path,
        File with(path) exists
    )
    
    size := method(path,
        File with(path) size
    )
)