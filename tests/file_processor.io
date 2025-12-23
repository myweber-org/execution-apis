
FileProcessor := Object clone

FileProcessor read := method(path,
    file := File with(path)
    file openForReading
    content := file readToEnd
    file close
    content
)

FileProcessor write := method(path, content,
    file := File with(path)
    file remove
    file openForUpdating
    file write(content)
    file close
    self
)

FileProcessor append := method(path, content,
    file := File with(path)
    file openForAppending
    file write(content)
    file close
    self
)

FileProcessor exists := method(path,
    File exists(path)
)

FileProcessor copy := method(source, destination,
    content := self read(source)
    self write(destination, content)
    self
)