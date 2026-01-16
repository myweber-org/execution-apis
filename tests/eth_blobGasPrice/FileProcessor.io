
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents
        ,
            Exception raise("File not found: " .. path)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file openForUpdating truncateToSize(0) write(content) close
        content size
    )
    
    processLines := method(path, processor,
        content := self readFile(path)
        lines := content split("\n")
        lines map(processor) join("\n")
    )
    
    countWords := method(path,
        content := self readFile(path)
        content split(" ") select(s, s size > 0) size
    )
)

processor := FileProcessor clone
result := processor writeFile("test.txt", "Hello World\nThis is a test")
"Written #{result} bytes" interpolate println

wordCount := processor countWords("test.txt")
"Word count: #{wordCount}" interpolate println

processed := processor processLines("test.txt", block(line, line upperCase))
processor writeFile("processed.txt", processed)