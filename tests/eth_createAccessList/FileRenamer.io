
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
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        counter := 1
        files foreach(i, file,
            if(file name beginsWithSeq(".") not,
                extension := if(file name containsSeq("."), 
                    "." .. file name split(".") last, 
                    ""
                )
                newName := prefix .. counter .. extension
                oldPath := directoryPath .. "/" .. file name
                newPath := directoryPath .. "/" .. newName
                if(File clone with(oldPath) exists,
                    File clone with(oldPath) renameTo(newPath)
                    "Renamed: #{file name} -> #{newName}" interpolate println
                    counter = counter + 1
                )
            )
        )
        "Total files renamed: #{counter - 1}" interpolate println
    )
)

if(isLaunchScript,
    if(System args size >= 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        "Usage: io FileRenamer.io <directory> <prefix>" println
    )
)