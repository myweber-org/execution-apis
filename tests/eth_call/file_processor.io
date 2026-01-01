
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
    true
)

FileProcessor append := method(path, content,
    file := File with(path)
    file openForAppending
    file write(content)
    file close
    true
)

FileProcessor exists := method(path,
    File exists(path)
)

FileProcessor copy := method(source, destination,
    content := self read(source)
    self write(destination, content)
)

FileProcessor move := method(source, destination,
    self copy(source, destination)
    File remove(source)
)