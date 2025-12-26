
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
        File exists(path)
    )
    
    getFileSize := method(path,
        file := File with(path)
        file size
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file openForUpdating
        file write(content)
        file close
        content size
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        content size
    )
    
    copyFile := method(sourcePath, destPath,
        content := self readFile(sourcePath)
        self writeFile(destPath, content)
    )
)

processor := FileProcessor clone
testContent := "Hello, Io World!\nThis is a test file."
bytesWritten := processor writeFile("test.txt", testContent)
"Wrote #{bytesWritten} bytes to test.txt" println

copiedBytes := processor copyFile("test.txt", "test_copy.txt")
"Copied file with #{copiedBytes} bytes" println

appendedBytes := processor appendToFile("test.txt", "\nAppended line!")
"Appended #{appendedBytes} bytes" println

readContent := processor readFile("test.txt")
"File contents:\n#{readContent}" println