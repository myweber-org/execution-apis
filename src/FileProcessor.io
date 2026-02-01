
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file readToEnd
        file close
        content
    )
    
    countLines := method(content,
        if(content isNil, return 0)
        content split("\n") size
    )
    
    processFile := method(path,
        content := self readFile(path)
        if(content isNil,
            writeln("File not found: ", path)
            return nil
        )
        lines := self countLines(content)
        writeln("File: ", path)
        writeln("Lines: ", lines)
        writeln("Content length: ", content size, " characters")
        content
    )
)