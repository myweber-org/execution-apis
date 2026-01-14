
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