
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File exists(path),
            originalFile := File with(path)
            timestamp := Date clone now asString("%Y%m%d_%H%M%S")
            extension := originalFile name split(".") last
            baseName := originalFile name split(".") slice(0, -1) join(".")
            newName := timestamp .. "_" .. baseName .. "." .. extension
            newPath := originalFile parentPath .. "/" .. newName
            
            originalFile moveTo(newPath)
            writeln("Renamed: ", path, " -> ", newPath)
            return newPath
        ,
            writeln("File not found: ", path)
            return nil
        )
    )
)

if(isLaunchScript,
    args := System args
    if(args size > 1,
        FileRenamer renameWithTimestamp(args at(1))
    ,
        writeln("Usage: io FileRenamer.io <filename>")
    )
)
FileRenamer := Object clone do(
    renameFilesWithPrefix := method(directory, prefix,
        files := Directory with(directory) files
        files foreach(i, file,
            oldPath := file path
            newName := prefix .. file name
            newPath := Path with(directory) appendPath(newName)
            if(oldPath != newPath,
                file moveTo(newPath)
                writeln("Renamed: ", file name, " -> ", newName)
            )
        )
        writeln("Renaming complete for ", files size, " files")
    )
)

if(isLaunchScript,
    if(System args size >= 3,
        FileRenamer renameFilesWithPrefix(System args at(1), System args at(2))
    ,
        writeln("Usage: io FileRenamer.io <directory> <prefix>")
    )
)