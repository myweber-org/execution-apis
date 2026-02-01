
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File exists(path),
            originalFile := File with(path)
            timestamp := Date clone now asString("%Y%m%d_%H%M%S")
            extension := originalFile path pathExtension
            baseName := originalFile path fileNameWithoutExtension
            newPath := originalFile path pathDirectory .. "/" .. timestamp .. "_" .. baseName .. "." .. extension
            
            if(originalFile exists not,
                return "File does not exist: #{path}" interpolate
            )
            
            originalFile moveTo(newPath)
            return "Renamed to: #{newPath}" interpolate
        ,
            return "Invalid file path: #{path}" interpolate
        )
    )
)
FileRenamer := Object clone do(
    renameFiles := method(directory, prefix, startNumber,
        files := Directory with(directory) files
        sortedFiles := files sortBy(block(a, b, a name < b name))
        counter := startNumber
        
        sortedFiles foreach(i, file,
            extension := if(file name containsSeq("."), 
                "." .. file name split(".") last, 
                ""
            )
            newName := prefix .. counter .. extension
            oldPath := directory .. "/" .. file name
            newPath := directory .. "/" .. newName
            
            if(File clone with(oldPath) exists,
                File clone with(oldPath) renameTo(newPath)
                "Renamed: #{file name} -> #{newName}" interpolate println
                counter = counter + 1
            )
        )
        
        "Total files renamed: #{counter - startNumber}" interpolate println
    )
)

if(isLaunchScript,
    if(System args size >= 3,
        directory := System args at(0)
        prefix := System args at(1)
        startNumber := System args at(2) asNumber
        
        if(Directory with(directory) exists not,
            "Directory not found: #{directory}" interpolate println
            return
        )
        
        FileRenamer renameFiles(directory, prefix, startNumber)
    ,
        "Usage: io FileRenamer.io <directory> <prefix> <startNumber>" println
    )
)