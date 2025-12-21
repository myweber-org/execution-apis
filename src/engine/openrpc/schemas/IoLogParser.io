
LogParser := Object clone do(
    parseLog := method(logString,
        lines := logString split("\n")
        parsedData := Map clone
        lines foreach(line,
            if(line containsSeq("ERROR") or line containsSeq("WARNING"),
                parsedData atPut(line, line)
            )
        )
        parsedData
    )
    
    analyzeLog := method(parsedData,
        errorCount := 0
        warningCount := 0
        parsedData values foreach(value,
            if(value containsSeq("ERROR"), errorCount = errorCount + 1)
            if(value containsSeq("WARNING"), warningCount = warningCount + 1)
        )
        Map clone atPut("errors", errorCount) atPut("warnings", warningCount)
    )
    
    generateReport := method(analysis,
        report := "Log Analysis Report\n"
        report = report .. "=================\n"
        report = report .. "Total Errors: " .. analysis at("errors") .. "\n"
        report = report .. "Total Warnings: " .. analysis at("warnings") .. "\n"
        report
    )
)

parser := LogParser clone
sampleLog := "INFO: Application started\nERROR: File not found\nWARNING: Memory usage high\nINFO: Processing data\nERROR: Database connection failed"
parsed := parser parseLog(sampleLog)
analysis := parser analyzeLog(parsed)
report := parser generateReport(analysis)
report println