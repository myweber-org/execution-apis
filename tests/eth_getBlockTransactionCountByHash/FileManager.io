
FileManager := Object clone do(
    readFile := method(path,
        file := File with(path) openForReading
        content := file readToEnd
        file close
        content
    )

    writeFile := method(path, content,
        file := File with(path) openForUpdating
        file remove
        file openForAppending
        file write(content)
        file close
        self
    )

    exists := method(path,
        File with(path) exists
    )
)