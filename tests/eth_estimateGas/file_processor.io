
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
    logPath := "file_processor.log"
    
    init := method(
        self logFile := File with(logPath) openForAppending
    )
    
    processFile := method(filePath,
        self log("Processing file: #{filePath}" interpolate)
        
        file := File with(filePath)
        if(file exists not,
            self logError("File not found: #{filePath}" interpolate)
            return nil
        )
        
        content := file read
        if(content isNil,
            self logError("Failed to read file: #{filePath}" interpolate)
            return nil
        )
        
        processed := content asUppercase
        self log("Processed #{filePath}, size: #{content size}" interpolate)
        return processed
    )
    
    log := method(message,
        timestamp := Date now asString("%Y-%m-%d %H:%M:%S")
        entry := "[#{timestamp}] #{message}" interpolate
        logFile write(entry, "\n")
        logFile flush
    )
    
    logError := method(message,
        self log("ERROR: #{message}" interpolate)
    )
    
    close := method(
        logFile close
    )
)

processor := FileProcessor clone
result := processor processFile("test.txt")
if(result isNil not, "Processed content: #{result}" interpolate println)
processor close