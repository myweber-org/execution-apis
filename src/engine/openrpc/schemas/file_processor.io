
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
    file openForUpdating
    file write(content)
    file close
)

FileProcessor append := method(path, content,
    file := File with(path)
    file openForAppending
    file write(content)
    file close
)

FileProcessor exists := method(path,
    File exists(path)
)