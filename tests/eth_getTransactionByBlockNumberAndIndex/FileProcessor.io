
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file readToEnd
        file close
        content
    )
    
    countLines := method(path,
        content := self readFile(path)
        if(content isNil, return 0)
        content split("\n") size
    )
    
    printFileInfo := method(path,
        lines := self countLines(path)
        if(lines == 0,
            "File not found or empty: #{path}" interpolate println,
            "File '#{path}' has #{lines} lines" interpolate println
        )
    )
)