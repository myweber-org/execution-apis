
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