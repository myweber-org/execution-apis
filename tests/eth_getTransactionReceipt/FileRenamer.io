
FileRenamer := Object clone do(
    renameFilesInDirectory := method(directoryPath,
        directory := Directory with(directoryPath)
        if(directory isNil, return "Directory not found")
        
        files := directory files map(file, 
            Map clone atPut("path", file path) atPut("created", file creationDate)
        )
        
        files sortBy("created") foreach(i, fileInfo,
            oldPath := fileInfo at("path")
            extension := PathExtension with(oldPath) extension ? ""
            newName := "document_" .. (i+1) asString(100) .. extension
            newPath := PathExtension with(oldPath) directoryPath .. "/" .. newName
            
            if(oldPath != newPath,
                File clone setPath(oldPath) renameTo(newPath)
                ("Renamed: " .. PathExtension with(oldPath) fileName .. " -> " .. newName) println
            )
        )
        "Renaming complete" println
    )
)

if(isLaunchScript,
    if(System args size > 1,
        FileRenamer renameFilesInDirectory(System args at(1))
    ,
        "Usage: io FileRenamer.io <directory_path>" println
    )
)