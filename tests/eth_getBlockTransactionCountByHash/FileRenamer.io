
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        files sortByKey("name")
        counter := 1
        files foreach(i, file,
            extension := file name split(".") last
            newName := "#{prefix}#{counter}.#{extension}" interpolate
            oldPath := file path
            newPath := Path with(directoryPath) appendPath(newName)
            if(oldPath != newPath,
                file moveTo(newPath)
                writeln("Renamed: ", oldPath, " -> ", newPath)
            )
            counter = counter + 1
        )
        writeln("Renamed ", files size, " files.")
    )
)