
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