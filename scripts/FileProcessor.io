
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