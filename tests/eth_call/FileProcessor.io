
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