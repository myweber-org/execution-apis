
LogParser := Object clone do(
    parseLog := method(logString,
        lines := logString split("\n")
        parsedData := Map clone
        lines foreach(line,
            if(line size > 0,
                parts := line split("=")
                if(parts size == 2,
                    key := parts at(0) strip
                    value := parts at(1) strip
                    parsedData atPut(key, value)
                )
            )
        )
        parsedData
    )
    
    analyzeLog := method(parsedData,
        analysis := Map clone
        parsedData keys foreach(key,
            value := parsedData at(key)
            analysis atPut(key .. "_length", value size)
            analysis atPut(key .. "_has_number", value containsRegex("\\d"))
        )
        analysis
    )
    
    generateReport := method(parsedData, analysis,
        report := "Log Analysis Report\n" ..
                  "==================\n\n" ..
                  "Parsed Data:\n"
        
        parsedData keys foreach(key,
            report = report .. "  " .. key .. ": " .. parsedData at(key) .. "\n"
        )
        
        report = report .. "\nAnalysis:\n"
        analysis keys foreach(key,
            report = report .. "  " .. key .. ": " .. analysis at(key) .. "\n"
        )
        
        report
    )
)

// Example usage
testLog := "timestamp=2023-10-05T14:30:00
level=INFO
message=System started successfully
user_count=42"

parser := LogParser clone
parsed := parser parseLog(testLog)
analysis := parser analyzeLog(parsed)
report := parser generateReport(parsed, analysis)

report println