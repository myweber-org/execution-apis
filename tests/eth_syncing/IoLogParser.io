
LogParser := Object clone do(
    parseLogFile := method(filePath,
        lines := File with(filePath) openForReading readLines
        lines map(line,
            parts := line split(" ")
            if(parts size >= 3,
                Map with(
                    "timestamp", parts at(0),
                    "level", parts at(1),
                    "message", parts slice(2) join(" ")
                ),
                Map with("error", "Invalid log format")
            )
        )
    )

    filterByLevel := method(logEntries, level,
        logEntries select(entry, entry at("level") == level)
    )

    countByLevel := method(logEntries,
        counts := Map clone
        logEntries foreach(entry,
            level := entry at("level")
            counts atPut(level, counts atIfAbsent(level, 0) + 1)
        )
        counts
    )
)

LogAnalyzer := LogParser clone do(
    analyzeLogFile := method(filePath,
        entries := self parseLogFile(filePath)
        levelCounts := self countByLevel(entries)
        errors := self filterByLevel(entries, "ERROR")
        
        analysis := Map with(
            "total_entries", entries size,
            "level_distribution", levelCounts,
            "error_count", errors size,
            "sample_error", if(errors size > 0, errors first at("message"), "No errors")
        )
        analysis
    )
)