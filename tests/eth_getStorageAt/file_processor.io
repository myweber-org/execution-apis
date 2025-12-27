
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading
            content := file readToEnd
            file close
            content
        ,
            "File not found: #{path}" interpolate
        )
    )

    writeFile := method(path, content,
        file := File with(path)
        file openForUpdating
        file write(content)
        file close
        "Written #{content size} bytes to #{path}" interpolate
    )

    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        "Appended #{content size} bytes to #{path}" interpolate
    )
)

// Example usage
processor := FileProcessor clone
result := processor writeFile("test.txt", "Hello, Io!")
result println

content := processor readFile("test.txt")
content println

processor appendToFile("test.txt", "\nAppended line!")
updated := processor readFile("test.txt")
updated println
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
        file openForUpdating write(content)
        file close
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending write(content)
        file close
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