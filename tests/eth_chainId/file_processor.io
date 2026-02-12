
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
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
        true
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        true
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists not, return 0)
        file size
    )
)
FileProcessor := Object clone do(
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
        file openForUpdating truncateToSize(0) write(content) close
        content size
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
        content size
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists, file size, 0)
    )
)
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
        file openForUpdating remove write(content) close
        content size
    )
    
    append := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
        content size
    )
)

processor := FileProcessor clone
testContent := "Hello, Io World!\nThis is a test file."

try(
    bytesWritten := processor write("test_output.txt", testContent)
    "Wrote #{bytesWritten} bytes to test_output.txt" println
    
    appendedBytes := processor append("test_output.txt", "\nAppended line!")
    "Appended #{appendedBytes} bytes to test_output.txt" println
    
    fileContent := processor read("test_output.txt")
    "File content:\n#{fileContent}" println
) catch(Exception,
    writeln("Error: ", error)
)