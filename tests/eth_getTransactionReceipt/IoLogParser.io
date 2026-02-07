
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