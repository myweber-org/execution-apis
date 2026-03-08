
FileManager := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
        "Written #{content size} bytes to #{path}" interpolate
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        if(file exists,
            file openForAppending write(content) close,
            writeFile(path, content)
        )
        "Appended #{content size} bytes to #{path}" interpolate
    )
)

// Example usage (commented out):
// manager := FileManager clone
// manager writeFile("test.txt", "Hello Io World!")
// result := manager readFile("test.txt")
// manager appendToFile("test.txt", "\nAppended line!")
// result println