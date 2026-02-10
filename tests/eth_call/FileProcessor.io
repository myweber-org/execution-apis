
FileProcessor := Object clone do(
    open := method(path,
        e := try(
            file := File with(path)
            file openForReading
            file
        )
        e catch(Exception,
            writeln("Error opening file: ", e error)
            nil
        )
    )

    processLines := method(file,
        lines := list()
        file foreachLine(line, lines append(line))
        lines
    )

    lazyProcess := method(path,
        LazySequence withBlock(
            file := self open(path)
            if(file != nil,
                self processLines(file) map(line, line strip)
            )
        )
    )
)

LazySequence := Object clone do(
    withBlock := method(block,
        self clone setBlock(block)
    )

    setBlock := method(block,
        self block := block
        self
    )

    map := method(transform,
        LazySequence withBlock(
            self block ifNonNil(
                call target block call map(transform)
            )
        )
    )

    asList := method(
        self block ifNonNil(call evalArgAt(0))
    )
)

processor := FileProcessor clone
result := processor lazyProcess("data.txt") map(line, line asUppercase)
writeln("Processed lines: ", result asList)
FileProcessor := Object clone do(
    countLines := method(path,
        file := File with(path)
        if(file exists not, return "File not found")
        file openForReading
        count := 0
        file foreachLine(count = count + 1)
        file close
        count
    )

    filterLines := method(path, pattern,
        file := File with(path)
        if(file exists not, return "File not found")
        result := List clone
        file openForReading
        file foreachLine(line,
            if(line contains(pattern), result append(line))
        )
        file close
        result
    )

    processFile := method(path, pattern,
        lines := countLines(path)
        filtered := filterLines(path, pattern)
        Map clone atPut("totalLines", lines) atPut("filteredLines", filtered)
    )
)
FileProcessor := Object clone do(
    process := method(path,
        file := File with(path)
        if(file exists not, return nil)
        
        file openForReading
        content := file contents
        file close
        
        lines := content split("\n")
        lines select(line, line size > 0) map(line,
            line strip split(" ") select(word, word size > 0)
        ) reduce(total, words,
            total + words size
        )
    )
    
    lazyProcess := method(path,
        lazy := LazySequence clone
        lazy setGenerator(block(
            self process(path)
        ))
        lazy
    )
    
    batchProcess := method(paths,
        results := List clone
        paths foreach(path,
            result := self process(path)
            if(result, results append(result))
            Exception catch(Exception,
                writeln("Error processing: ", path)
            )
        )
        results
    )
)
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading contents
        ,
            Exception raise("File not found: #{path}" interpolate)
        )
    )

    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating write(content) close
        content
    )

    appendFile := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
        content
    )

    exists := method(path,
        File with(path) exists
    )
)