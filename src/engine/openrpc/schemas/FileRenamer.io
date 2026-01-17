
FileRenamer := Object clone do(
    renameFilesInDirectory := method(directoryPath,
        directory := Directory with(directoryPath)
        files := directory files map(file,
            Map clone atPut("path", file path) atPut("modified", file lastDataChange)
        ) sortBy("modified")

        counter := 1
        files foreach(fileInfo,
            oldPath := fileInfo at("path")
            extension := PathExtension with(oldPath)
            newName := "#{counter}.#{extension}" interpolate
            newPath := Path with(directoryPath, newName) asString

            if(oldPath != newPath,
                File clone setPath(oldPath) renameTo(newPath)
                "Renamed: #{Path with(oldPath) name} -> #{newName}" interpolate println
            )

            counter = counter + 1
        )
    )
)

if(isLaunchScript,
    if(System args size > 1,
        FileRenamer renameFilesInDirectory(System args at(1))
    ,
        "Usage: #{System launchPath} <directory>" interpolate println
    )
)
FileRenamer := Object clone do(
    renameFiles := method(path, prefix,
        files := Directory with(path) files
        files sortBy(createdAt)
        counter := 1
        
        files foreach(file,
            extension := file path split(".") last
            newName := "#{prefix}#{counter}.#{extension}" interpolate
            newPath := Path with(path, newName)
            
            if(File clone with(newPath) exists,
                Exception raise("File #{newPath} already exists" interpolate)
            )
            
            file moveTo(newPath)
            writeln("Renamed: #{file name} -> #{newName}" interpolate)
            counter = counter + 1
        )
        
        writeln("Renamed #{counter - 1} files successfully")
    )
)

if(isLaunchScript,
    if(System args size < 3,
        writeln("Usage: io FileRenamer.io <directory_path> <prefix>")
        System exit(1)
    )
    
    path := System args at(1)
    prefix := System args at(2)
    
    try(
        FileRenamer renameFiles(path, prefix)
    ) catch(Exception,
        writeln("Error: ", error)
        System exit(1)
    )
)