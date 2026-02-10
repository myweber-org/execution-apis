
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
report printlnLogParser := Object clone do(
    parseFile := method(filePath,
        lines := File with(filePath) openForReading readLines
        lines map(line,
            parts := line split(" ")
            Map with(
                "timestamp", parts at(0),
                "level", parts at(1),
                "message", parts join(" ", 2)
            )
        )
    )

    filterByLevel := method(logs, level,
        logs select(log, log at("level") == level)
    )

    countByLevel := method(logs,
        counts := Map clone
        logs foreach(log,
            level := log at("level")
            counts atPut(level, (counts at(level) ? 0) + 1)
        )
        counts
    )
)

parser := LogParser clone
sampleLogs := list(
    "2023-10-01T10:00:00 INFO System started",
    "2023-10-01T10:01:00 WARN Low disk space",
    "2023-10-01T10:02:00 ERROR Database connection failed",
    "2023-10-01T10:03:00 INFO User login successful"
)

parsed := parser parseFile("sample.log")
errorLogs := parser filterByLevel(parsed, "ERROR")
levelCounts := parser countByLevel(parsed)

"Parsed #{parsed size} log entries" println
"Found #{errorLogs size} error logs" println
"Level distribution: #{levelCounts}" println