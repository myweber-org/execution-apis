
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        sortedFiles := files sortBy(block(a, b, a name < b name))
        counter := 1
        
        sortedFiles foreach(file,
            extension := if(file name containsSeq("."), 
                "." .. file name split(".") last, 
                ""
            )
            newName := prefix .. counter asString(100) .. extension
            oldPath := directoryPath .. "/" .. file name
            newPath := directoryPath .. "/" .. newName
            
            if(oldPath != newPath,
                File rename(oldPath, newPath)
                writeln("Renamed: ", file name, " -> ", newName)
            )
            counter = counter + 1
        )
        writeln("Renamed ", counter - 1, " files.")
    )
)

if(isLaunchScript,
    if(System args size == 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        writeln("Usage: io FileRenamer.io <directory> <prefix>")
    )
)
FileRenamer := Object clone do(
    renameFile := method(path,
        if(File with(path) exists,
            timestamp := Date clone now asString("%Y%m%d_%H%M%S")
            newPath := path .. "_" .. timestamp
            File with(path) renameTo(newPath)
            writeln("Renamed '", path, "' to '", newPath, "'")
        ,
            writeln("File '", path, "' does not exist")
        )
    )

    renameFilesInDirectory := method(directoryPath,
        Directory with(directoryPath) files foreach(file,
            renameFile(file path)
        )
    )
)

if(isLaunchScript,
    if(System args size > 1,
        FileRenamer renameFilesInDirectory(System args at(1))
    ,
        writeln("Usage: io FileRenamer.io <directory>")
    )
)