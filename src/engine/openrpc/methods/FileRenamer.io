
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
FileRenamer := Object clone do(
    renameFiles := method(path, prefix,
        directory := Directory with(path)
        directory files foreach(i, file,
            oldPath := file path
            newName := prefix .. file name
            newPath := path pathComponent(newName)
            if(oldPath != newPath,
                file moveTo(newPath)
                writeln("Renamed: ", file name, " -> ", newName)
            )
        )
        writeln("Batch renaming completed.")
    )
)

if(isLaunchScript,
    if(System args size == 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        writeln("Usage: io FileRenamer.io <directory_path> <prefix>")
    )
)