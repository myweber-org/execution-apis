
LogParser := Object clone do(
    parseLogFile := method(filePath,
        lines := File with(filePath) openForReading readLines
        parsedLogs := lines map(line,
            parts := line split(" - ")
            if(parts size == 3,
                Map with(
                    "timestamp", parts at(0),
                    "level", parts at(1),
                    "message", parts at(2)
                ),
                nil
            )
        ) select(isNil not)
        parsedLogs
    )

    filterByLevel := method(logs, level,
        logs select(log, log at("level") == level)
    )

    countByLevel := method(logs,
        counts := Map clone
        logs foreach(log,
            level := log at("level")
            counts atPut(level, (counts at(level) ifNilEval(0)) + 1)
        )
        counts
    )

    findErrors := method(logs,
        logs select(log, log at("message") containsSeq("ERROR"))
    )
)

// Example usage
parser := LogParser clone
parsedLogs := parser parseLogFile("application.log")
errorLogs := parser filterByLevel(parsedLogs, "ERROR")
levelCounts := parser countByLevel(parsedLogs)
criticalErrors := parser findErrors(parsedLogs)

"Parsed #{parsedLogs size} log entries" println
"Found #{errorLogs size} error logs" println
levelCounts foreach(level, count, "#{level}: #{count}" println)
LogParser := Object clone do(
    parseLogFile := method(filePath,
        file := File with(filePath)
        if(file exists not, return nil)
        
        lines := file readLines
        parsedLogs := List clone
        
        lines foreach(line,
            if(line containsSeq("ERROR") or line containsSeq("WARNING"),
                parsedLogs append(Map clone atPut("line", line) atPut("timestamp", Date clone now))
            )
        )
        
        parsedLogs
    )
    
    analyzeLogs := method(logs,
        errorCount := 0
        warningCount := 0
        
        logs foreach(log,
            if(log at("line") containsSeq("ERROR"), errorCount = errorCount + 1)
            if(log at("line") containsSeq("WARNING"), warningCount = warningCount + 1)
        )
        
        Map clone atPut("total", logs size) atPut("errors", errorCount) atPut("warnings", warningCount)
    )
    
    generateReport := method(analysis,
        report := "Log Analysis Report\n"
        report = report .. "=================\n"
        report = report .. "Total log entries: " .. analysis at("total") asString .. "\n"
        report = report .. "Error entries: " .. analysis at("errors") asString .. "\n"
        report = report .. "Warning entries: " .. analysis at("warnings") asString .. "\n"
        report = report .. "Clean entries: " .. (analysis at("total") - analysis at("errors") - analysis at("warnings")) asString .. "\n"
        
        report
    )
)

LogParserTest := Object clone do(
    runTest := method(
        "Testing LogParser" println
        
        testLogs := list(
            "2023-10-01 INFO: System started",
            "2023-10-01 ERROR: Connection failed",
            "2023-10-01 WARNING: High memory usage",
            "2023-10-01 INFO: Backup completed",
            "2023-10-01 ERROR: Database timeout"
        )
        
        parser := LogParser clone
        analysis := parser analyzeLogs(testLogs)
        report := parser generateReport(analysis)
        
        report println
        "Test completed" println
    )
)

if(isLaunchScript,
    LogParserTest runTest
)