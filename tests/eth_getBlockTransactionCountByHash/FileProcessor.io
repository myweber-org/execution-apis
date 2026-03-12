
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

    appendToFile := method(path, content,
        file := File with(path)
        file exists ifFalse(
            Exception raise("File not exist for append: #{path}" interpolate)
        )
        file openForAppending write(content) close
        content
    )

    fileExists := method(path,
        File with(path) exists
    )

    getFileSize := method(path,
        file := File with(path)
        file exists ifTrue(
            file size
        ) ifFalse(
            Exception raise("File not found: #{path}" interpolate)
        )
    )
)