
FileRenamer := Object clone do(
    renameFiles := method(directoryPath,
        files := Directory with(directoryPath) files
        counter := 1
        files foreach(file,
            if(file name endsWithSeq(".txt"),
                newName := "document_" .. counter .. ".txt"
                oldPath := file path
                newPath := Path with(directoryPath) appendPath(newName)
                file setPath(newPath)
                writeln("Renamed: ", oldPath, " -> ", newPath)
                counter = counter + 1
            )
        )
        writeln("Total files renamed: ", counter - 1)
    )
)

if(isLaunchScript,
    if(System args size > 1,
        FileRenamer renameFiles(System args at(1))
    ,
        writeln("Please provide a directory path as argument")
    )
)