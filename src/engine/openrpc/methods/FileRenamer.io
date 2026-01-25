
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        counter := 1
        files foreach(file,
            extension := file path split(".") last
            newName := "#{prefix}#{counter}.#{extension}" interpolate
            newPath := Path with(directoryPath, newName)
            file moveTo(newPath)
            counter = counter + 1
        )
        "Renamed #{files size} files" interpolate println
    )
)