
LogParser := Object clone do(
    parseLog := method(logString,
        lines := logString split("\n")
        parsedData := Map clone
        lines foreach(i, line,
            if(line size > 0,
                parts := line split(": ")
                if(parts size == 2,
                    key := parts at(0) asMutable strip
                    value := parts at(1) asMutable strip
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
            analysis atPut(key .. "_words", value split(" ") size)
        )
        analysis
    )
    
    generateReport := method(parsedData, analysis,
        report := "Log Analysis Report\n"
        report = report .. "=" repeated(30) .. "\n"
        
        parsedData keys foreach(key,
            report = report .. "Key: " .. key .. "\n"
            report = report .. "Value: " .. parsedData at(key) .. "\n"
            report = report .. "Value Length: " .. analysis at(key .. "_length") .. "\n"
            report = report .. "Word Count: " .. analysis at(key .. "_words") .. "\n"
            report = report .. "-" repeated(30) .. "\n"
        )
        report
    )
)

logString := "error: Division by zero
timestamp: 2024-01-15T10:30:00Z
module: MathOperations
user: john_doe"

parser := LogParser clone
parsedData := parser parseLog(logString)
analysis := parser analyzeLog(parsedData)
report := parser generateReport(parsedData, analysis)

report println