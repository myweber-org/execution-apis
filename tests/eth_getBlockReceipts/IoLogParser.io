
LogParser := Object clone do(
    parseLog := method(logString,
        lines := logString split("\n")
        parsedLog := Map clone
        lines foreach(i, line,
            if(line size > 0,
                parts := line split(": ")
                if(parts size == 2,
                    key := parts at(0)
                    value := parts at(1)
                    parsedLog atPut(key, value)
                )
            )
        )
        parsedLog
    )
    
    analyzeLog := method(parsedLog,
        analysis := Map clone
        analysis atPut("entryCount", parsedLog size)
        
        errorCount := 0
        parsedLog values foreach(value,
            if(value asLowercase containsSeq("error"), errorCount = errorCount + 1)
        )
        analysis atPut("errorCount", errorCount)
        
        warningCount := 0
        parsedLog values foreach(value,
            if(value asLowercase containsSeq("warning"), warningCount = warningCount + 1)
        )
        analysis atPut("warningCount", warningCount)
        
        analysis
    )
    
    formatReport := method(parsedLog, analysis,
        report := "Log Analysis Report\n"
        report = report .. "=================\n\n"
        report = report .. "Parsed Entries:\n"
        parsedLog keys sort foreach(key,
            report = report .. "  " .. key .. ": " .. parsedLog at(key) .. "\n"
        )
        report = report .. "\nAnalysis Summary:\n"
        analysis keys sort foreach(key,
            report = report .. "  " .. key .. ": " .. analysis at(key) asString .. "\n"
        )
        report
    )
)

LogProcessor := LogParser clone do(
    processLogFile := method(logContent,
        parsed := parseLog(logContent)
        analysis := analyzeLog(parsed)
        formatReport(parsed, analysis)
    )
)

testLog := "timestamp: 2023-10-05T14:30:00Z
level: INFO
message: Application started successfully
module: Main
timestamp: 2023-10-05T14:31:15Z
level: WARNING
message: High memory usage detected
module: MemoryMonitor
timestamp: 2023-10-05T14:32:45Z
level: ERROR
message: Database connection failed
module: Database"

processor := LogProcessor clone
result := processor processLogFile(testLog)
result println