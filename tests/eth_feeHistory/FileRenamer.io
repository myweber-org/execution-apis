
FileRenamer := Object clone do(
    renameFiles := method(path, prefix,
        directory := Directory with(path)
        directory files foreach(i, file,
            oldPath := file path
            newName := prefix .. file name
            newPath := path .. "/" .. newName
            if(oldPath != newPath,
                file moveTo(newPath)
                "Renamed: #{file name} -> #{newName}" interpolate println
            )
        )
        "Renaming complete." println
    )
)

if(isLaunchScript,
    if(System args size >= 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        "Usage: io FileRenamer.io <directory_path> <prefix>" println
    )
)