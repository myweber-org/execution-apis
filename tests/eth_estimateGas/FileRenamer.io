
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File with(path) exists not,
            Exception raise("File not found: #{path}" interpolate)
        )
        
        originalFile := File with(path)
        timestamp := Date clone now asString("%Y%m%d_%H%M%S")
        extension := if(originalFile name containsSeq("."), 
            "." .. originalFile name split(".") last, 
            ""
        )
        baseName := originalFile name beforeSeq(extension)
        newName := "#{timestamp}_#{baseName}#{extension}" interpolate
        newPath := originalFile parentPath .. "/" .. newName
        
        originalFile renameTo(newPath)
        writeln("Renamed: #{path} -> #{newName}" interpolate)
        return newPath
    )
    
    renameMultiple := method(paths,
        results := List clone
        paths foreach(path,
            try(
                newPath := renameWithTimestamp(path)
                results append(newPath)
            ) catch(Exception,
                writeln("Error processing #{path}: #{Exception description}" interpolate)
            )
        )
        return results
    )
)

if(isLaunchScript,
    args := System args slice(1)
    if(args isEmpty,
        writeln("Usage: io FileRenamer.io <file1> [file2 ...]")
        System exit(1)
    )
    
    FileRenamer renameMultiple(args)
)