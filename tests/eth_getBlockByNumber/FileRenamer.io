
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File with(path) exists not, return "File not found")
        
        originalFile := File with(path)
        timestamp := Date now asString("%Y%m%d_%H%M%S")
        extension := if(originalFile name containsSeq("."), 
            "." .. originalFile name split(".") last, 
            ""
        )
        baseName := originalFile name beforeSeq(extension)
        newName := timestamp .. "_" .. baseName .. extension
        newPath := originalFile parentPath .. "/" .. newName
        
        originalFile renameTo(newPath)
        return "Renamed to: #{newName}" interpolate
    )
    
    renameMultiple := method(pathList,
        results := list()
        pathList foreach(path,
            results append(renameWithTimestamp(path))
        )
        return results
    )
)

if(isLaunchScript,
    if(System args size > 1,
        System args slice(1) foreach(arg,
            result := FileRenamer renameWithTimestamp(arg)
            result println
        )
    )
)