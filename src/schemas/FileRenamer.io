
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        files sortBy(createdAt)
        counter := 1
        files foreach(file,
            extension := file path pathExtension
            newName := "#{prefix}#{counter}.#{extension}" interpolate
            newPath := Path with(directoryPath) appendPath(newName)
            file moveTo(newPath)
            counter = counter + 1
        )
        "Renamed #{files size} files" interpolate println
    )
)