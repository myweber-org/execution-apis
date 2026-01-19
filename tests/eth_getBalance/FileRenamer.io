
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        directory := Directory with(directoryPath)
        if(directory exists not, return "Directory not found.")
        files := directory files select(f, f isFile)
        files sortInPlace(by(name))
        counter := 1
        files foreach(f,
            extension := f path extension
            newName := "#{prefix}#{counter}.#{extension}" interpolate
            newPath := f path parentPath / newName
            f moveTo(newPath)
            counter = counter + 1
        )
        "Renamed #{files size} files." interpolate
    )
)