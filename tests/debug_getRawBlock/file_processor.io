
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
        file openForUpdating
        file write(content)
        file close
        self
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        self
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        try(
            File with(path) openForReading contents
        ) catch(Exception,
            writeln("Error reading file: ", path)
            nil
        )
    )
    
    writeFile := method(path, content,
        try(
            file := File with(path) openForUpdating
            file write(content)
            file close
            true
        ) catch(Exception,
            writeln("Error writing to file: ", path)
            false
        )
    )
    
    appendToFile := method(path, content,
        try(
            file := File with(path) openForAppending
            file write(content)
            file close
            true
        ) catch(Exception,
            writeln("Error appending to file: ", path)
            false
        )
    )
)

processor := FileProcessor clone
result := processor readFile("input.txt")
if(result, processor writeFile("output.txt", result))