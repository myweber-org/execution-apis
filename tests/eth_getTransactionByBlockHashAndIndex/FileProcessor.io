
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
        file openForUpdating write(content)
        file close
    )

    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending write(content)
        file close
    )

    exists := method(path,
        File with(path) exists
    )
)