
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