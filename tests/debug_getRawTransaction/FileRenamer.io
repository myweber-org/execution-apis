
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        files sortBy(createdAt)
        counter := 1
        files foreach(file,
            extension := if(file name containsSeq("."), 
                "." .. file name split(".") last, 
                ""
            )
            newName := prefix .. "_" .. counter asString(100) .. extension
            oldPath := file path
            newPath := Path with(directoryPath) appendPath(newName)
            if(oldPath != newPath,
                file moveTo(newPath)
                writeln("Renamed: ", oldPath, " -> ", newPath)
            )
            counter = counter + 1
        )
        writeln("Renamed ", counter - 1, " files")
    )
)

if(isLaunchScript,
    if(System args size >= 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        writeln("Usage: io FileRenamer.io <directory> <prefix>")
    )
)