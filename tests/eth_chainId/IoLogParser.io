
LogParser := Object clone do(
    parseLogFile := method(filePath,
        file := File with(filePath)
        if(file exists not, return nil)
        
        lines := file readLines
        parsedData := Map clone
        
        lines foreach(i, line,
            if(line containsSeq("ERROR") or line containsSeq("WARNING"),
                timestamp := line findRegex("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")
                message := line afterSeq("] ") ifNil(line)
                
                entry := Map clone
                entry atPut("timestamp", timestamp)
                entry atPut("message", message)
                entry atPut("line_number", i + 1)
                
                if(line containsSeq("ERROR"),
                    parsedData atPut("errors", 
                        parsedData at("errors") ifNil(List clone) append(entry)
                    )
                )
                
                if(line containsSeq("WARNING"),
                    parsedData atPut("warnings",
                        parsedData at("warnings") ifNil(List clone) append(entry)
                    )
                )
            )
        )
        
        parsedData atPut("total_lines", lines size)
        parsedData atPut("processed_at", Date now asString("%Y-%m-%d %H:%M:%S"))
        return parsedData
    )
    
    generateReport := method(parsedData,
        report := "Log Analysis Report\n"
        report = report .. "=================\n"
        report = report .. "Processed at: #{parsedData at(\"processed_at\")}\n" interpolate
        report = report .. "Total lines: #{parsedData at(\"total_lines\")}\n" interpolate
        
        errors := parsedData at("errors") ifNil(List clone)
        warnings := parsedData at("warnings") ifNil(List clone)
        
        report = report .. "\nErrors found: #{errors size}\n" interpolate
        errors foreach(error,
            report = report .. "  Line #{error at(\"line_number\")}: #{error at(\"message\")}\n" interpolate
        )
        
        report = report .. "\nWarnings found: #{warnings size}\n" interpolate
        warnings foreach(warning,
            report = report .. "  Line #{warning at(\"line_number\")}: #{warning at(\"message\")}\n" interpolate
        )
        
        return report
    )
    
    analyzeLogFile := method(filePath,
        parsedData := self parseLogFile(filePath)
        if(parsedData isNil, return "File not found or cannot be read")
        
        report := self generateReport(parsedData)
        
        summary := Map clone
        summary atPut("file", filePath)
        summary atPut("error_count", parsedData at("errors") ifNil(List clone) size)
        summary atPut("warning_count", parsedData at("warnings") ifNil(List clone) size)
        summary atPut("analysis_complete", true)
        
        return Map clone atPut("report", report) atPut("summary", summary)
    )
)

LogParserTest := Object clone do(
    runTest := method(
        testLog := "test.log"
        
        testContent := List clone
        testContent append("2023-10-01 12:00:00 [INFO] Application started")
        testContent append("2023-10-01 12:00:05 [WARNING] Memory usage above threshold")
        testContent append("2023-10-01 12:00:10 [ERROR] Database connection failed")
        testContent append("2023-10-01 12:00:15 [INFO] Retrying connection")
        
        File with(testLog) open write(testContent join("\n")) close
        
        result := LogParser analyzeLogFile(testLog)
        
        File with(testLog) remove
        
        return result at("summary")
    )
)