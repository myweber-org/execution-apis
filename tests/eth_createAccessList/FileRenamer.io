
FileRenamer := Object clone do(
    renameFiles := method(path, prefix,
        directory := Directory with(path)
        directory files foreach(i, file,
            oldName := file name
            newName := prefix .. oldName
            newPath := path .. "/" .. newName
            file moveTo(newPath)
            writeln("Renamed: ", oldName, " -> ", newName)
        )
    )
)

if(isLaunchScript,
    if(System args size >= 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        writeln("Usage: io FileRenamer.io <directory_path> <prefix>")
    )
)