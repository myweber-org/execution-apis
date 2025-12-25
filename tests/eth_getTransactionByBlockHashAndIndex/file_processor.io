
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
        file remove
        file openForUpdating
        file write(content)
        file close
    )
    
    appendFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
    )
    
    exists := method(path,
        File exists(path)
    )
    
    size := method(path,
        file := File with(path)
        file size
    )
)

processor := FileProcessor clone
testPath := "test_output.txt"

if(processor exists(testPath) not,
    processor writeFile(testPath, "Initial content\n")
)

processor appendFile(testPath, "Appended line\n")

writeln("File content:")
writeln(processor readFile(testPath))
writeln("File size: ", processor size(testPath), " bytes")