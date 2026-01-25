
FileProcessor := Object clone do(
    read := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents
        ,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
    
    write := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
        content size
    )
    
    append := method(path, content,
        file := File with(path)
        if(file exists,
            file openForAppending write(content) close
        ,
            file openForUpdating write(content) close
        )
        content size
    )
    
    exists := method(path,
        File with(path) exists
    )
    
    size := method(path,
        file := File with(path)
        if(file exists,
            file size
        ,
            Exception raise("File not found: #{path}" interpolate)
        )
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
            file := File with(path)
            file openForUpdating truncateToSize(0)
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
            file := File with(path)
            file openForAppending
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
if(result, 
    processor writeFile("output.txt", result)
    processor appendToFile("log.txt", "File processed successfully\n")
)