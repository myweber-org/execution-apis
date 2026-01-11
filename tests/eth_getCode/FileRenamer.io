
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File with(path) exists not,
            Exception raise("File not found: #{path}" interpolate)
        )
        
        timestamp := Date clone now asString("%Y%m%d_%H%M%S")
        dir := Path with(path) parentPath
        baseName := Path with(path) fileName
        newPath := dir .. "/" .. timestamp .. "_" .. baseName
        
        File with(path) moveTo(newPath)
        newPath
    )
    
    renameMultiple := method(pathList,
        results := List clone
        pathList foreach(path,
            try(
                newPath := self renameWithTimestamp(path)
                results append(newPath)
            ) catch(Exception,
                results append("Failed: #{path}" interpolate)
            )
        )
        results
    )
)