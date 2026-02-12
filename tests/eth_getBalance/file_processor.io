
FileProcessor := Object clone do(
    readCSV := method(path,
        file := File with(path) openForReading
        lines := file readLines
        file close
        lines map(line, line split(","))
    )
    
    writeCSV := method(path, data,
        file := File with(path) openForUpdating
        data foreach(row,
            line := row join(",")
            file write(line, "\n")
        )
        file close
    )
    
    filterRows := method(data, columnIndex, value,
        data select(row, row at(columnIndex) asString == value asString)
    )
    
    getColumn := method(data, columnIndex,
        data map(row, row at(columnIndex))
    )
)
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
        true
    )
    
    appendToFile := method(path, content,
        file := File with(path)
        file openForAppending write(content) close
        true
    )
    
    fileExists := method(path,
        File with(path) exists
    )
    
    getFileSize := method(path,
        file := File with(path)
        if(file exists, file size, 0)
    )
)