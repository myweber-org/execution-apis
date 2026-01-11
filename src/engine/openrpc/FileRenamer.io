
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
    
    processDirectory := method(dirPath,
        directory := Directory with(dirPath)
        if(directory exists not,
            Exception raise("Directory not found: #{dirPath}" interpolate)
        )
        
        directory files foreach(file,
            if(file isDirectory not,
                try(
                    renameWithTimestamp(file path)
                ) catch(Exception,
                    writeln("Failed to rename #{file name}: #{error}" interpolate)
                )
            )
        )
    )
)

if(isLaunchScript,
    args := System args
    if(args size < 2,
        writeln("Usage: io FileRenamer.io <file_or_directory>")
        System exit(1)
    )
    
    target := args at(1)
    file := File with(target)
    
    if(file exists,
        if(file isDirectory,
            FileRenamer processDirectory(target)
        ,
            FileRenamer renameWithTimestamp(target)
        )
    ,
        writeln("Path does not exist: #{target}" interpolate)
    )
)