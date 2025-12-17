
FileProcessor := Object clone do(
    size := method(path,
        File with(path) size
    )

    lineCount := method(path,
        File with(path) openForReading readLines size
    )

    process := method(path,
        if(File with(path) exists,
            writeln("Processing: ", path)
            writeln("Size: ", self size(path), " bytes")
            writeln("Lines: ", self lineCount(path))
        ,
            writeln("File not found: ", path)
        )
    )
)