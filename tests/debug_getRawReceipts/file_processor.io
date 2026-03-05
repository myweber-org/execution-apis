
FileProcessor := Object clone do(
    countLines := method(path,
        file := File with(path)
        if(file exists not, return 0)
        file openForReading
        count := 0
        file foreachLine(line, count = count + 1)
        file close
        count
    )
    
    filterLines := method(path, pattern,
        result := List clone
        file := File with(path)
        if(file exists not, return result)
        file openForReading
        file foreachLine(line,
            if(line contains(pattern),
                result append(line)
            )
        )
        file close
        result
    )
    
    writeLines := method(path, lines,
        file := File with(path)
        file remove
        file openForUpdating
        lines foreach(line,
            file write(line, "\n")
        )
        file close
        self
    )
)

processor := FileProcessor clone
lines := processor filterLines("input.txt", "important")
count := processor countLines("input.txt")
processor writeLines("output.txt", lines)