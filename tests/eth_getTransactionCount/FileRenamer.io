
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        files sortByKey("name")
        counter := 1
        
        files foreach(i, file,
            extension := file name split(".") last
            newName := "#{prefix}#{counter}.#{extension}" interpolate
            newPath := Path with(directoryPath, newName)
            
            if(file path != newPath,
                writeln("Renaming: ", file name, " -> ", newName)
                file moveTo(newPath)
            )
            counter = counter + 1
        )
        writeln("Renamed ", files size, " files")
    )
)

if(isLaunchScript,
    if(System args size >= 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        writeln("Usage: io FileRenamer.io <directory> <prefix>")
    )
)