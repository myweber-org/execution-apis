
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File with(path) exists,
            timestamp := Date clone now asString("%Y%m%d_%H%M%S")
            extension := if(path containsSeq("."), "." .. path split(".") last, "")
            baseName := if(extension size > 0, path exSlice(0, -(extension size)), path)
            newPath := timestamp .. "_" .. baseName .. extension
            
            File with(path) renameTo(newPath)
            writeln("Renamed: ", path, " -> ", newPath)
            return newPath
        ,
            writeln("File not found: ", path)
            return nil
        )
    )
    
    processDirectory := method(dirPath,
        Directory with(dirPath) files foreach(file,
            if(file isDirectory not,
                renameWithTimestamp(file path)
            )
        )
    )
)

if(isLaunchScript,
    args := System args
    if(args size > 1,
        path := args at(1)
        if(Directory with(path) exists,
            FileRenamer processDirectory(path)
        ,
            FileRenamer renameWithTimestamp(path)
        )
    ,
        writeln("Usage: io FileRenamer.io <file_or_directory>")
    )
)