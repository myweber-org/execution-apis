
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
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(Directory with(path) exists not and File with(path) exists not,
            Exception raise("Path does not exist: #{path}" interpolate)
        )
        
        oldFile := File with(path)
        timestamp := Date now asString("%Y%m%d_%H%M%S")
        extension := if(oldFile path extension, "." .. oldFile path extension, "")
        baseName := oldFile nameWithoutExtension
        newName := "#{timestamp}_#{baseName}#{extension}" interpolate
        newPath := oldFile directory path / newName
        
        oldFile moveTo(newPath)
        writeln("Renamed: #{path} -> #{newPath}" interpolate)
        return newPath
    )
    
    renameDirectoryContents := method(dirPath,
        directory := Directory with(dirPath)
        if(directory exists not,
            Exception raise("Directory does not exist: #{dirPath}" interpolate)
        )
        
        results := List clone
        directory files foreach(file,
            try(
                newPath := renameWithTimestamp(file path)
                results append(newPath)
            ) catch(Exception,
                writeln("Failed to rename #{file path}: #{error}" interpolate)
            )
        )
        return results
    )
)

if(isLaunchScript,
    if(System args size == 1,
        FileRenamer renameWithTimestamp(System args at(0))
    ) else(
        writeln("Usage: io FileRenamer.io <file_or_directory_path>")
    )
)