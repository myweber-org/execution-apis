
LogParser := Object clone do(
    parseLogFile := method(filePath,
        file := File with(filePath)
        if(file exists not, return nil)
        
        lines := file readLines
        parsedData := Map clone
        
        lines foreach(i, line,
            if(line size > 0,
                parts := line split(" - ")
                if(parts size >= 2,
                    timestamp := parts at(0)
                    message := parts at(1)
                    parsedData atPut(timestamp, message)
                )
            )
        )
        
        parsedData
    )
    
    filterByKeyword := method(parsedData, keyword,
        filtered := Map clone
        parsedData foreach(timestamp, message,
            if(message contains(keyword),
                filtered atPut(timestamp, message)
            )
        )
        filtered
    )
    
    generateReport := method(parsedData,
        report := "Log Analysis Report\n"
        report = report .. "Total entries: #{parsedData size}\n" interpolate
        
        if(parsedData size > 0,
            timestamps := parsedData keys sort
            report = report .. "Time range: #{timestamps first} to #{timestamps last}\n" interpolate
            
            errorCount := 0
            parsedData foreach(timestamp, message,
                if(message asLowercase containsSeq("error"), errorCount = errorCount + 1)
            )
            report = report .. "Error entries: #{errorCount}\n" interpolate
        )
        
        report
    )
)

LogAnalyzer := LogParser clone do(
    analyzePatterns := method(parsedData,
        patterns := Map clone
        parsedData foreach(timestamp, message,
            words := message split(" ")
            words foreach(word,
                if(word size > 3,
                    count := patterns at(word) ifNil(0)
                    patterns atPut(word, count + 1)
                )
            )
        )
        patterns
    )
    
    findMostFrequent := method(patterns, limit := 10,
        sorted := patterns keys sortBy(key, patterns at(key)) reverse
        sorted slice(0, limit min(sorted size))
    )
)