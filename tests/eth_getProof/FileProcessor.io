
FileProcessor := Object clone do(
    processFile := method(path,
        file := File with(path)
        if(file exists not, return "File not found")
        
        content := file openForReading contents
        file close
        
        words := content split(" ") select(word, word size > 0)
        wordCount := words size
        charCount := content size
        
        return "Processed: #{wordCount} words, #{charCount} characters" interpolate
    )
    
    // Example usage
    if(isLaunchScript,
        processor := FileProcessor clone
        result := processor processFile("sample.txt")
        result println
    )
)