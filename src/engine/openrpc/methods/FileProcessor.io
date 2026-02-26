
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
)