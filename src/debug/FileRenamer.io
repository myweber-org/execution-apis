
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File exists(path),
            originalFile := File with(path)
            timestamp := Date clone now asString("%Y%m%d_%H%M%S")
            extension := originalFile path extension
            baseName := originalFile path baseName
            newName := timestamp .. "_" .. baseName .. extension
            newPath := originalFile path parentPath .. "/" .. newName
            
            originalFile moveTo(newPath)
            writeln("Renamed: ", path, " -> ", newPath)
            return newPath
        ,
            writeln("Error: File not found - ", path)
            return nil
        )
    )
    
    renameMultiple := method(pathList,
        results := list()
        pathList foreach(path,
            result := renameWithTimestamp(path)
            if(result, results append(result))
        )
        return results
    )
)
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
            newName := prefix .. counter .. extension
            oldPath := directoryPath .. "/" .. file name
            newPath := directoryPath .. "/" .. newName
            
            if(File clone with(oldPath) exists,
                File clone with(oldPath) renameTo(newPath)
                write("Renamed: ", file name, " -> ", newName, "\n")
            )
            counter = counter + 1
        )
        write("Renaming complete.\n")
    )
)

if(isLaunchScript,
    if(System args size == 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        write("Usage: io FileRenamer.io <directory> <prefix>\n")
    )
)