
LogParser := Object clone do(
    parseLog := method(logString,
        lines := logString split("\n")
        parsedData := Map clone
        lines foreach(line,
            if(line size > 0,
                parts := line split(": ")
                if(parts size == 2,
                    key := parts at(0)
                    value := parts at(1)
                    parsedData atPut(key, value)
                )
            )
        )
        parsedData
    )
    
    analyzeLog := method(parsedData,
        analysis := Map clone
        parsedData keys foreach(key,
            value := parsedData at(key)
            analysis atPut(key .. "_length", value size)
            analysis atPut(key .. "_words", value split(" ") size)
        )
        analysis
    )
    
    generateReport := method(parsedData, analysis,
        report := "Log Analysis Report\n"
        report = report .. "=" repeated(30) .. "\n"
        
        parsedData keys foreach(key,
            report = report .. "Key: " .. key .. "\n"
            report = report .. "Value: " .. parsedData at(key) .. "\n"
            report = report .. "Value Length: " .. analysis at(key .. "_length") .. "\n"
            report = report .. "Word Count: " .. analysis at(key .. "_words") .. "\n"
            report = report .. "-" repeated(30) .. "\n"
        )
        report
    )
)

LogProcessor := LogParser clone do(
    processLogFile := method(filePath,
        file := File with(filePath)
        if(file exists not,
            return "Error: File not found"
        )
        
        logContent := file openForReading contents
        file close
        
        parsedData := parseLog(logContent)
        analysis := analyzeLog(parsedData)
        report := generateReport(parsedData, analysis)
        
        report
    )
    
    saveReport := method(report, outputPath,
        file := File with(outputPath)
        file openForUpdating write(report)
        file close
        "Report saved to: " .. outputPath
    )
)

// Example usage
processor := LogProcessor clone
sampleLog := "timestamp: 2024-01-15 10:30:00
level: INFO
message: Application started successfully
user: john_doe
session_id: abc123-def456-ghi789"

parsed := processor parseLog(sampleLog)
analysis := processor analyzeLog(parsed)
report := processor generateReport(parsed, analysis)

report println