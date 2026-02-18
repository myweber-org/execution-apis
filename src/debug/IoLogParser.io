
LogParser := Object clone do(
    parseLogFile := method(filePath,
        file := File with(filePath) openForReading
        lines := file readLines
        file close

        parsedData := List clone
        lines foreach(line,
            if(line containsSeq("ERROR") or line containsSeq("WARNING"),
                parsedData append(line)
            )
        )
        parsedData
    )

    analyzeLogs := method(logData,
        errorCount := 0
        warningCount := 0
        
        logData foreach(line,
            if(line containsSeq("ERROR"), errorCount = errorCount + 1)
            if(line containsSeq("WARNING"), warningCount = warningCount + 1)
        )
        
        Map clone atPut("errors", errorCount) atPut("warnings", warningCount)
    )

    generateReport := method(analysis,
        report := "Log Analysis Report:\n"
        report = report .. "Total Errors: " .. analysis at("errors") asString .. "\n"
        report = report .. "Total Warnings: " .. analysis at("warnings") asString .. "\n"
        
        if(analysis at("errors") > 0,
            report = report .. "Status: CRITICAL - Errors detected\n"
        ,
            if(analysis at("warnings") > 0,
                report = report .. "Status: WARNING - Warnings detected\n"
            ,
                report = report .. "Status: OK - No issues found\n"
            )
        )
        report
    )
)

parser := LogParser clone
logData := parser parseLogFile("application.log")
analysis := parser analyzeLogs(logData)
report := parser generateReport(analysis)

report println