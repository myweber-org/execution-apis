
FileProcessor := Object clone do(
    countLines := method(path,
        file := File with(path) openForReading
        lines := 0
        file foreachLine(lines = lines + 1)
        file close
        lines
    )
    
    countWords := method(path,
        file := File with(path) openForReading
        content := file readToEnd
        file close
        words := content split(" ") select(w, w size > 0) size
        words
    )
    
    processFile := method(path,
        lines := self countLines(path)
        words := self countWords(path)
        Map clone atPut("path", path) atPut("lines", lines) atPut("words", words)
    )
)

processor := FileProcessor clone
result := processor processFile("sample.txt")
result keys foreach(key,
    value := result at(key)
    ("#{key}: #{value}" interpolate) println
)
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        content := file readToEnd
        file close
        content
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating
        file write(content)
        file close
        self
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        self
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists not, return 0)
        file size
    )
)

FileProcessor clone
FileProcessor := Object clone do(
    read := method(path,
        file := File with(path)
        if(file exists, file readLines, nil)
    )

    write := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating
        file write(content)
        file close
        true
    )

    append := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        true
    )

    exists := method(path,
        File with(path) exists
    )
)