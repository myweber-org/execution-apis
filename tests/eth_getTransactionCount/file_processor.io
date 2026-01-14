
FileProcessor := Object clone do(
    init := method(
        self.log := List clone
        self.errorCount := 0
    )

    processFile := method(filePath,
        self log append("Processing: #{filePath}" interpolate)
        
        try(
            file := File with(filePath)
            if(file exists not,
                Exception raise("File not found: #{filePath}" interpolate)
            )
            
            content := file openForReading contents
            self log append("Read #{content size} bytes" interpolate)
            
            // Example processing: count lines
            lineCount := content split("\n") size
            self log append("Total lines: #{lineCount}" interpolate)
            
            file close
            return lineCount
        ) catch(Exception,
            self errorCount = self errorCount + 1
            self log append("Error: #{exception error}" interpolate)
            return nil
        )
    )

    getStats := method(
        Map clone atPut("totalOperations", self log size) \
                 atPut("errors", self errorCount) \
                 atPut("logs", self log)
    )
)

// Usage example
processor := FileProcessor clone
processor processFile("test.txt")
processor processFile("missing.txt")
stats := processor getStats
stats at("logs") foreach(log, log println)