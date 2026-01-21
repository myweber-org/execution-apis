
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File with(path) exists,
            timestamp := Date clone now asString("%Y%m%d_%H%M%S")
            dir := Path with(path) parentPath
            baseName := Path with(path) fileName
            newPath := dir .. "/" .. timestamp .. "_" .. baseName
            
            if(File with(path) renameTo(newPath),
                return "Renamed to: #{newPath}" interpolate
            ,
                return "Failed to rename file"
            )
        ,
            return "File does not exist"
        )
    )
)

if(isLaunchScript,
    if(System args size > 1,
        FileRenamer renameWithTimestamp(System args at(1)) println
    ,
        "Usage: io FileRenamer.io <filepath>" println
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
                writeln("Renamed: ", oldPath, " -> ", newPath)
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