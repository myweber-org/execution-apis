
FileProcessor := Object clone do(
    readAndFilter := method(path, filterBlock,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        lines := list()
        file foreachLine(line,
            if(filterBlock call(line), lines append(line))
        )
        file close
        lines
    )
    
    countLines := method(path,
        file := File with(path)
        if(file exists not, return 0)
        file openForReading
        count := 0
        file foreachLine(line, count = count + 1)
        file close
        count
    )
)FileProcessor := Object clone do(
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
    )

    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending write(content)
        file close
    )

    fileExists := method(path,
        File with(path) exists
    )
)