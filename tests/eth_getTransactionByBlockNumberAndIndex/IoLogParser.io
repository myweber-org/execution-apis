
LogParser := Object clone do(
    parseLog := method(logString,
        lines := logString split("\n")
        parsedLines := lines map(line,
            parts := line split(" - ")
            if(parts size == 3,
                Map with(
                    "timestamp", parts at(0),
                    "level", parts at(1),
                    "message", parts at(2)
                ),
                line
            )
        )
        parsedLines
    )
    
    filterByLevel := method(parsedLog, level,
        parsedLog select(item,
            if(item isKindOf(Map),
                item at("level") == level,
                false
            )
        )
    )
    
    countByLevel := method(parsedLog,
        counts := Map clone
        parsedLog foreach(item,
            if(item isKindOf(Map),
                level := item at("level")
                currentCount := counts at(level) ifNil(0)
                counts atPut(level, currentCount + 1)
            )
        )
        counts
    )
    
    getLatestMessages := method(parsedLog, limit,
        messages := parsedLog select(item, item isKindOf(Map)) reverse
        if(messages size > limit,
            messages slice(0, limit - 1),
            messages
        )
    )
)

// Example usage
testLog := "2023-10-05T10:30:00 - INFO - Application started
2023-10-05T10:31:00 - WARNING - High memory usage detected
2023-10-05T10:32:00 - ERROR - Database connection failed
2023-10-05T10:33:00 - INFO - Retrying connection
2023-10-05T10:34:00 - ERROR - Connection timeout"

parser := LogParser clone
parsed := parser parseLog(testLog)

"Parsed log:" println
parsed println

"Error messages:" println
parser filterByLevel(parsed, "ERROR") println

"Message counts:" println
parser countByLevel(parsed) println

"Latest 2 messages:" println
parser getLatestMessages(parsed, 2) println
LogParser := Object clone do(
    parseLog := method(logString,
        lines := logString split("\n")
        parsedData := Map clone
        lines foreach(line,
            if(line containsSeq("ERROR") or line containsSeq("WARNING"),
                key := line split(" ")[0]
                parsedData atPut(key, line)
            )
        )
        parsedData
    )
    
    analyzeLog := method(logString,
        parsed := self parseLog(logString)
        errorCount := 0
        warningCount := 0
        
        parsed values foreach(value,
            if(value containsSeq("ERROR"), errorCount = errorCount + 1)
            if(value containsSeq("WARNING"), warningCount = warningCount + 1)
        )
        
        Map clone atPut("errors", errorCount) atPut("warnings", warningCount) atPut("total", parsed size)
    )
    
    formatReport := method(analysis,
        report := "Log Analysis Report\n"
        report = report .. "=================\n"
        report = report .. "Total entries: " .. analysis at("total") .. "\n"
        report = report .. "Errors: " .. analysis at("errors") .. "\n"
        report = report .. "Warnings: " .. analysis at("warnings") .. "\n"
        report
    )
)

// Example usage
testLog := "2023-10-01 ERROR: Connection failed
2023-10-01 WARNING: High memory usage
2023-10-01 INFO: System started
2023-10-02 ERROR: Database timeout
2023-10-02 INFO: Backup completed"

parser := LogParser clone
analysis := parser analyzeLog(testLog)
report := parser formatReport(analysis)
report println