
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