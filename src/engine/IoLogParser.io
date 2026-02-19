
LogParser := Object clone do(
    parseLogFile := method(filePath,
        lines := File with(filePath) openForReading readLines
        lines foreach(i, line,
            if(line containsSeq("ERROR") or line containsSeq("WARNING"),
                writeln("Found issue at line ", i + 1, ": ", line)
            )
        )
        return lines size
    )
    
    analyzeLogs := method(directory,
        totalLines := 0
        Directory with(directory) files foreach(file,
            if(file name endsWith(".log"),
                writeln("Processing: ", file path)
                totalLines = totalLines + LogParser parseLogFile(file path)
            )
        )
        writeln("Total lines processed: ", totalLines)
    )
)

// Example usage
if(isLaunchScript,
    LogParser analyzeLogs("./logs")
)