
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File exists(path),
            originalFile := File with(path)
            timestamp := Date clone now asString("%Y%m%d_%H%M%S")
            extension := if(originalFile name containsSeq("."), 
                "." .. originalFile name split(".") last, 
                ""
            )
            baseName := originalFile name beforeSeq(extension)
            newName := timestamp .. "_" .. baseName .. extension
            newPath := originalFile parentPath .. "/" .. newName
            
            originalFile rename(newPath)
            writeln("Renamed: ", path, " -> ", newPath)
            return newPath
        ,
            writeln("File not found: ", path)
            return nil
        )
    )
    
    batchRename := method(fileList,
        results := list()
        fileList foreach(file,
            results append(renameWithTimestamp(file))
        )
        results
    )
)

if(isLaunchScript,
    args := System args slice(1)
    if(args size > 0,
        FileRenamer batchRename(args)
    ,
        writeln("Usage: io FileRenamer.io <file1> <file2> ...")
    )
)