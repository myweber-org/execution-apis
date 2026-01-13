
LogParser := Object clone do(
    parseLog := method(logString,
        lines := logString split("\n")
        parsedLines := lines map(line,
            parts := line split(" - ")
            if(parts size == 3,
                Map clone atPut("timestamp", parts at(0)) atPut("level", parts at(1)) atPut("message", parts at(2)),
                Map clone atPut("error", "Invalid log format") atPut("raw", line)
            )
        )
        parsedLines
    )
    
    filterByLevel := method(parsedLogs, level,
        parsedLogs select(log, log at("level") == level)
    )
    
    countByLevel := method(parsedLogs,
        counts := Map clone
        parsedLogs foreach(log,
            level := log at("level")
            if(level,
                currentCount := counts at(level) ifNil(0)
                counts atPut(level, currentCount + 1)
            )
        )
        counts
    )
    
    getTimeRange := method(parsedLogs,
        timestamps := parsedLogs map(log, log at("timestamp")) select(timestamp, timestamp)
        if(timestamps isEmpty, return nil)
        
        sorted := timestamps sort
        Map clone atPut("start", sorted first) atPut("end", sorted last)
    )
)

LogAnalyzer := LogParser clone do(
    analyze := method(logString,
        parsed := self parseLog(logString)
        
        analysis := Map clone
        analysis atPut("totalEntries", parsed size)
        analysis atPut("levelCounts", self countByLevel(parsed))
        analysis atPut("timeRange", self getTimeRange(parsed))
        
        errorLogs := self filterByLevel(parsed, "ERROR")
        analysis atPut("errorCount", errorLogs size)
        analysis atPut("errorMessages", errorLogs map(log, log at("message")))
        
        analysis
    )
    
    generateReport := method(analysis,
        report := "Log Analysis Report\n"
        report = report .. "==================\n"
        report = report .. "Total entries: #{analysis at(\"totalEntries\")}\n" interpolate
        
        levelCounts := analysis at("levelCounts")
        levelCounts keys sort foreach(level,
            count := levelCounts at(level)
            report = report .. "#{level}: #{count}\n" interpolate
        )
        
        timeRange := analysis at("timeRange")
        if(timeRange,
            report = report .. "\nTime range:\n"
            report = report .. "  Start: #{timeRange at(\"start\")}\n" interpolate
            report = report .. "  End: #{timeRange at(\"end\")}\n" interpolate
        )
        
        errorCount := analysis at("errorCount")
        report = report .. "\nErrors found: #{errorCount}\n" interpolate
        
        if(errorCount > 0,
            report = report .. "\nError messages:\n"
            analysis at("errorMessages") foreach(message,
                report = report .. "  - #{message}\n" interpolate
            )
        )
        
        report
    )
)

// Example usage
testLog := "2023-10-05T08:30:00Z - INFO - Application started
2023-10-05T08:31:15Z - WARNING - High memory usage detected
2023-10-05T08:32:00Z - ERROR - Database connection failed
2023-10-05T08:33:45Z - INFO - Retrying connection
2023-10-05T08:34:20Z - ERROR - Connection timeout
2023-10-05T08:35:00Z - INFO - Connection established"

analyzer := LogAnalyzer clone
analysisResult := analyzer analyze(testLog)
report := analyzer generateReport(analysisResult)
report println