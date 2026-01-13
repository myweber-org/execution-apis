
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
            newName := prefix .. counter .. extension
            oldPath := directoryPath .. "/" .. file name
            newPath := directoryPath .. "/" .. newName
            if(File clone with(oldPath) exists,
                File clone with(oldPath) renameTo(newPath)
                "Renamed #{oldPath} to #{newPath}" interpolate println
            )
            counter = counter + 1
        )
        "Renaming complete. Processed #{files size} files." interpolate println
    )
)