
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        files sortByKey("name")
        counter := 1
        files foreach(file,
            extension := if(file name containsSeq("."), 
                "." .. file name split(".") last, 
                ""
            )
            newName := prefix .. counter asString(100) .. extension
            oldPath := directoryPath .. "/" .. file name
            newPath := directoryPath .. "/" .. newName
            if(oldPath != newPath,
                File rename(oldPath, newPath)
                writeln("Renamed: ", file name, " -> ", newName)
            )
            counter = counter + 1
        )
        writeln("Renaming complete. Processed ", counter - 1, " files.")
    )
)