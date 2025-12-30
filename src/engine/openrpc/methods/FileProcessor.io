
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents,
            Exception raise("File not found: #{path}" interpolate)
        )
    )
    
    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
        "Written #{content size} bytes to #{path}" interpolate
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        if(file exists not, file create)
        file openForAppending write(content) close
        "Appended #{content size} bytes to #{path}" interpolate
    )
    
    copyFile := method(source, destination,
        content := self readFile(source)
        self writeFile(destination, content)
    )
)
FileProcessor := Object clone do(
    readLines := method(path,
        file := File with(path)
        if(file exists not, return nil)
        file openForReading
        lines := file readLines
        file close
        lines map(line, line strip)
    )

    processLines := method(lines, processor,
        lines map(line,
            try(
                processor call(line)
            ) catch(Exception,
                writeln("Error processing line: ", line)
                nil
            )
        ) select(result, result != nil)
    )

    lazyProcess := method(path, processor,
        LazySequence with(
            file := File with(path)
            if(file exists not, return LazySequence empty)
            file openForReading
            
            next := method(
                while(file isAtEnd not,
                    line := file readLine strip
                    if(line size > 0,
                        result := try(
                            processor call(line)
                        ) catch(Exception, nil)
                        if(result, return result)
                    )
                )
                file close
                nil
            )
        )
    )
)

processor := block(line,
    if(line beginsWithSeq("#"), return nil)
    line split("=") map(part, part strip)
)

lines := FileProcessor readLines("config.txt")
processed := FileProcessor processLines(lines, processor)

lazyResults := FileProcessor lazyProcess("large.txt", processor)
firstFive := lazyResults first(5) asList