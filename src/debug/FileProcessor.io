
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