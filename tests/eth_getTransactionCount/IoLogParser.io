
LogParser := Object clone do(
    parseLogFile := method(filePath,
        file := File with(filePath)
        if(file exists not, return "File not found: #{filePath}" interpolate)
        
        lines := file readLines
        parsedData := Map clone
        
        lines foreach(i, line,
            if(line containsSeq("ERROR") or line containsSeq("WARN") or line containsSeq("INFO"),
                timestamp := line findRegex("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")
                level := line findRegex("ERROR|WARN|INFO")
                message := line split(" - ") at(1)
                
                if(timestamp and level and message,
                    entry := Map clone
                    entry atPut("timestamp", timestamp)
                    entry atPut("level", level)
                    entry atPut("message", message)
                    
                    parsedData atPut(i asString, entry)
                )
            )
        )
        
        parsedData
    )
    
    countByLevel := method(parsedData,
        counts := Map clone
        counts atPut("ERROR", 0)
        counts atPut("WARN", 0)
        counts atPut("INFO", 0)
        
        parsedData values foreach(entry,
            level := entry at("level")
            if(counts hasKey(level),
                current := counts at(level)
                counts atPut(level, current + 1)
            )
        )
        
        counts
    )
    
    filterByLevel := method(parsedData, level,
        filtered := Map clone
        parsedData foreach(key, entry,
            if(entry at("level") == level,
                filtered atPut(key, entry)
            )
        )
        filtered
    )
    
    generateReport := method(parsedData,
        counts := self countByLevel(parsedData)
        
        report := "Log Analysis Report\n"
        report = report .. "==================\n"
        report = report .. "Total entries: #{parsedData size}" interpolate .. "\n"
        report = report .. "ERROR count: #{counts at(\"ERROR\")}" interpolate .. "\n"
        report = report .. "WARN count: #{counts at(\"WARN\")}" interpolate .. "\n"
        report = report .. "INFO count: #{counts at(\"INFO\")}" interpolate .. "\n"
        
        report
    )
)

LogAnalyzer := LogParser clone do(
    analyzeLogFile := method(filePath,
        parsedData := self parseLogFile(filePath)
        if(parsedData type == "Sequence" and parsedData beginsWithSeq("File not found"),
            return parsedData
        )
        
        report := self generateReport(parsedData)
        
        if(self countByLevel(parsedData) at("ERROR") > 0,
            errorEntries := self filterByLevel(parsedData, "ERROR")
            report = report .. "\nError entries found:\n"
            errorEntries foreach(key, entry,
                report = report .. "#{entry at(\"timestamp\")} - #{entry at(\"message\")}" interpolate .. "\n"
            )
        )
        
        report
    )
)

parser := LogAnalyzer clone
result := parser analyzeLogFile("application.log")
result println