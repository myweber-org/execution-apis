
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
        self
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        self
    )
    
    copyFile := method(sourcePath, targetPath,
        content := self readFile(sourcePath)
        if(content, self writeFile(targetPath, content))
    )
)

processor := FileProcessor clone
testContent := processor readFile("input.txt")
if(testContent,
    processor writeFile("output.txt", testContent)
    processor appendToFile("log.txt", "File copied at #{Date clone now asString}\n" interpolate)
)