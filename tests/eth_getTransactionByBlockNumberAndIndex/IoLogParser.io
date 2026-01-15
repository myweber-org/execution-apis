
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