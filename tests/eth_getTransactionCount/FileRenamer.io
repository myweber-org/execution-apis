
FileRenamer := Object clone do(
    renameFiles := method(directory, prefix,
        files := Directory with(directory) files
        files sortByKey("name")
        counter := 1
        files foreach(i, file,
            extension := if(file name containsSeq("."), 
                "." .. file name split(".") last, 
                ""
            )
            newName := prefix .. counter asString(100) .. extension
            oldPath := directory .. "/" .. file name
            newPath := directory .. "/" .. newName
            if(oldPath != newPath,
                File rename(oldPath, newPath)
                writeln("Renamed: ", file name, " -> ", newName)
            )
            counter = counter + 1
        )
        writeln("Renaming complete. Processed ", counter - 1, " files.")
    )
)

if(isLaunchScript,
    if(System args size == 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        writeln("Usage: io FileRenamer.io <directory> <prefix>")
    )
)