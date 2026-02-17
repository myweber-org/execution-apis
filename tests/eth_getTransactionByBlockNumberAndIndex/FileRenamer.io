
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File with(path) exists not, return "File not found")
        
        originalFile := File with(path)
        timestamp := Date clone now asString("%Y%m%d_%H%M%S")
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
    
    processDirectory := method(dirPath,
        directory := Directory with(dirPath)
        if(directory exists not, return "Directory not found")
        
        results := list()
        directory files foreach(file,
            if(file isDirectory not,
                result := renameWithTimestamp(file path)
                results append(result)
            )
        )
        return results join("\n")
    )
)

if(isLaunchScript,
    if(System args size == 2,
        path := System args at(1)
        if(Directory with(path) exists,
            FileRenamer processDirectory(path) println
        ,
            FileRenamer renameWithTimestamp(path) println
        )
    ,
        "Usage: io FileRenamer.io <file_or_directory_path>" println
    )
)