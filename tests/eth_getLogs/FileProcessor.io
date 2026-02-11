
FileProcessor := Object clone do(
    getSize := method(path,
        File with(path) size
    )

    getLineCount := method(path,
        File with(path) openForReading readLines size
    )

    processFile := method(path,
        size := self getSize(path)
        lines := self getLineCount(path)
        writeln("File: ", path)
        writeln("Size: ", size, " bytes")
        writeln("Lines: ", lines)
        return list(size, lines)
    )
)
FileProcessor := Object clone do(
    readAndCountLines := method(path,
        file := File with(path)
        if(file exists not, return "File not found: #{path}" interpolate)
        lines := file readLines
        "File '#{path}' has #{lines size} lines" interpolate
    )
)

// Example usage (commented out)
// result := FileProcessor readAndCountLines("example.txt")
// result println