
LogParser := Object clone do(
    parseLogFile := method(filePath,
        file := File with(filePath) openForReading
        lines := file readLines
        file close
        lines map(line, line split(" | ") at(1))
    )
    
    countErrors := method(logEntries,
        logEntries select(entry, entry beginsWithSeq("ERROR")) size
    )
    
    filterByLevel := method(logEntries, level,
        logEntries select(entry, entry beginsWithSeq(level))
    )
)

parser := LogParser clone
sampleLog := list(
    "2023-10-05 INFO: System started",
    "2023-10-05 ERROR: Disk full",
    "2023-10-05 WARNING: High memory usage",
    "2023-10-05 INFO: Backup completed"
)

parsed := parser parseLogFile("dummy.log")
("Total entries: " .. parsed size) println
("Error count: " .. parser countErrors(parsed)) println
("Warnings: " .. parser filterByLevel(parsed, "WARNING") join(", ")) println