
LogParser := Object clone do(
    parseLog := method(logString,
        lines := logString split("\n")
        parsedData := Map clone
        lines foreach(line,
            if(line containsSeq("ERROR") or line containsSeq("WARNING"),
                parts := line split(" ", 2)
                if(parts size == 2,
                    timestamp := parts at(0)
                    message := parts at(1)
                    parsedData atPut(timestamp, message)
                )
            )
        )
        parsedData
    )
    
    analyzeLog := method(parsedData,
        errorCount := 0
        warningCount := 0
        parsedData values foreach(message,
            if(message containsSeq("ERROR"), errorCount = errorCount + 1)
            if(message containsSeq("WARNING"), warningCount = warningCount + 1)
        )
        Map clone atPut("errors", errorCount) atPut("warnings", warningCount)
    )
    
    formatReport := method(analysis,
        "Log Analysis Report:\n" ..
        "Errors: " .. (analysis at("errors")) asString .. "\n" ..
        "Warnings: " .. (analysis at("warnings")) asString
    )
)

logParser := LogParser clone
sampleLog := "2023-10-01 ERROR: Connection timeout\n2023-10-01 WARNING: High memory usage\n2023-10-02 ERROR: Database unreachable"

parsed := logParser parseLog(sampleLog)
analysis := logParser analyzeLog(parsed)
report := logParser formatReport(analysis)

report println
LogParser := Object clone do(
    parseLog := method(logString,
        lines := logString split("\n")
        parsedData := Map clone
        lines foreach(i, line,
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
            if(value containsSeq("ERROR"),
                analysis atPut("errorCount", analysis at("errorCount", 0) + 1)
            )
            if(value containsSeq("WARN"),
                analysis atPut("warningCount", analysis at("warningCount", 0) + 1)
            )
        )
        analysis
    )
    
    formatReport := method(analysis,
        report := "Log Analysis Report\n"
        report = report .. "=================\n"
        analysis keys foreach(key,
            report = report .. key .. ": " .. analysis at(key) asString .. "\n"
        )
        report
    )
)

parser := LogParser clone
sampleLog := "timestamp: 2023-10-05T14:30:00
level: INFO
message: Application started
timestamp: 2023-10-05T14:31:00
level: ERROR
message: Database connection failed
timestamp: 2023-10-05T14:32:00
level: WARN
message: High memory usage detected"

parsed := parser parseLog(sampleLog)
analysis := parser analyzeLog(parsed)
report := parser formatReport(analysis)
report println
LogParser := Object clone do(
    parseLog := method(logString,
        lines := logString split("\n")
        parsedLog := Map clone
        lines foreach(i, line,
            if(line size > 0,
                parts := line split(" ", 2)
                if(parts size == 2,
                    timestamp := parts at(0)
                    message := parts at(1)
                    parsedLog atPut(timestamp, message)
                )
            )
        )
        parsedLog
    )
    
    analyzeLog := method(parsedLog,
        analysis := Map clone
        analysis atPut("totalEntries", parsedLog size)
        
        errorCount := 0
        warningCount := 0
        parsedLog values foreach(message,
            if(message containsSeq("ERROR"), errorCount = errorCount + 1)
            if(message containsSeq("WARNING"), warningCount = warningCount + 1)
        )
        
        analysis atPut("errors", errorCount)
        analysis atPut("warnings", warningCount)
        analysis atPut("lastTimestamp", parsedLog keys max)
        analysis
    )
    
    formatAnalysis := method(analysis,
        result := "Log Analysis Report\n"
        result = result .. "=================\n"
        analysis keys foreach(key,
            result = result .. key .. ": " .. analysis at(key) .. "\n"
        )
        result
    )
)

// Example usage
testLog := "2023-10-01T10:00:00 INFO Application started
2023-10-01T10:00:05 WARNING Configuration file not found
2023-10-01T10:00:10 ERROR Database connection failed
2023-10-01T10:00:15 INFO Retrying connection
2023-10-01T10:00:20 WARNING Using default configuration
2023-10-01T10:00:25 INFO Database connected successfully"

parser := LogParser clone
parsed := parser parseLog(testLog)
analysis := parser analyzeLog(parsed)
parser formatAnalysis(analysis) println