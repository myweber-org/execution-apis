
FileProcessor := Object clone do(
    readAndCount := method(path,
        file := File with(path)
        if(file exists not, return nil)
        lines := file readLines
        map("lines" -> lines size, "content" -> lines)
    )
    
    processFile := method(path,
        result := self readAndCount(path)
        if(result,
            writeln("File: ", path)
            writeln("Total lines: ", result at("lines"))
            writeln("First 3 lines:")
            result at("content") slice(0, 2) foreach(i, line, writeln("  ", line))
        ,
            writeln("File not found: ", path)
        )
    )
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

    countLines := method(path,
        content := self readFile(path)
        if(content isNil, return 0)
        content split("\n") size
    )

    printFileInfo := method(path,
        lines := self countLines(path)
        if(lines == 0,
            "File not found or empty: #{path}" interpolate println,
            "File '#{path}' contains #{lines} lines" interpolate println
        )
    )
)

// Example usage (commented out)
// processor := FileProcessor clone
// processor printFileInfo("example.txt")