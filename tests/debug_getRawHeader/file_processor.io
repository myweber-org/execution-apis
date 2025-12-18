
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file contents
        file close
        content
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating
        file write(content)
        file close
        true
    )
    
    appendFile := method(path, content,
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

processor := FileProcessor clone
testPath := "test_output.txt"

if(processor fileExists(testPath) not,
    processor writeFile(testPath, "Initial content\n")
    "File created" println
)

processor appendFile(testPath, "Appended line\n")

content := processor readFile(testPath)
"File content:" println
content println

"File size: #{processor getFileSize(testPath)} bytes" interpolate println