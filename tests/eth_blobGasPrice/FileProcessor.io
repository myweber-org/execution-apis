
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
)