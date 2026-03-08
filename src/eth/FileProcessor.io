
FileProcessor := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists, file read, nil)
    )

    writeFile := method(path, content,
        file := File with(path)
        file remove
        file openForUpdating
        file write(content)
        file close
        true
    )

    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending
        file write(content)
        file close
        true
    )

    fileExists := method(path,
        File with(path) exists
    )
)