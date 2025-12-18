
LogParser := Object clone do(
    parseLogFile := method(filePath,
        lines := File with(filePath) openForReading readLines
        parsedLogs := List clone
        lines foreach(line,
            if(line containsSeq("ERROR") or line containsSeq("WARNING"),
                parsedLogs append(line)
            )
        )
        parsedLogs
    )
    
    countSeverity := method(logs,
        counts := Map clone
        logs foreach(log,
            if(log containsSeq("ERROR"),
                counts atPut("ERROR", counts at("ERROR") asNumber + 1)
            )
            if(log containsSeq("WARNING"),
                counts atPut("WARNING", counts at("WARNING") asNumber + 1)
            )
        )
        counts
    )
    
    filterByKeyword := method(logs, keyword,
        filtered := List clone
        logs foreach(log,
            if(log containsSeq(keyword),
                filtered append(log)
            )
        )
        filtered
    )
)

parser := LogParser clone
sampleLogs := list(
    "2024-01-15 ERROR: Database connection failed",
    "2024-01-15 INFO: System started successfully",
    "2024-01-15 WARNING: High memory usage detected",
    "2024-01-15 ERROR: File not found: config.io"
)

parsed := parser parseLogFile("application.log")
severityCounts := parser countSeverity(parsed)
errorLogs := parser filterByKeyword(parsed, "ERROR")

"Parsed logs: " println
parsed foreach(println)

"\nSeverity counts:" println
severityCounts foreach(key, value,
    ("  " .. key .. ": " .. value) println
)

"\nError logs:" println
errorLogs foreach(println)