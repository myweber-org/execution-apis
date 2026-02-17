
FileProcessor := Object clone do(
    readAndCountLines := method(filePath,
        file := File with(filePath)
        if(file exists not, return "File not found: #{filePath}" interpolate)
        if(file isDirectory, return "Path is a directory: #{filePath}" interpolate)
        
        lines := list()
        count := 0
        
        file openForReading
        file foreachLine(line,
            lines append(line)
            count = count + 1
        )
        file close
        
        map(
            "path": filePath,
            "lineCount": count,
            "content": lines
        )
    )
    
    processFiles := method(filePaths,
        results := list()
        filePaths foreach(filePath,
            result := self readAndCountLines(filePath)
            results append(result)
        )
        results
    )
)

// Example usage
processor := FileProcessor clone
filesToProcess := list("example.txt", "data.log", "config.ini")

results := processor processFiles(filesToProcess)
results foreach(result,
    if(result type == "Map",
        ("Processed: " .. result at("path") .. " - Lines: " .. result at("lineCount")) println
    ,
        ("Error: " .. result) println
    )
)
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
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists, return file size, return 0)
    )
)