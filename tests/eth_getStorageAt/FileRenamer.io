
FileRenamer := Object clone do(
    renameFiles := method(path, prefix,
        directory := Directory with(path)
        directory files foreach(i, file,
            oldPath := file path
            if(file isDirectory not,
                newName := prefix .. file name
                newPath := path pathComponent(newName)
                file renameTo(newPath)
                writeln("Renamed: ", oldPath, " -> ", newPath)
            )
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