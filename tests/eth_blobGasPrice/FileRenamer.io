
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        counter := 1
        files foreach(i, file,
            if(file name beginsWithSeq(".") not,
                extension := if(file name containsSeq("."), 
                    "." .. file name split(".") last, 
                    ""
                )
                newName := prefix .. counter .. extension
                oldPath := directoryPath .. "/" .. file name
                newPath := directoryPath .. "/" .. newName
                
                if(File clone with(oldPath) exists,
                    File clone with(oldPath) renameTo(newPath)
                    write("Renamed: ", oldPath, " -> ", newName, "\n")
                )
                counter = counter + 1
            )
        )
        write("Total files renamed: ", counter - 1, "\n")
    )
)

if(isLaunchScript,
    if(System args size == 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        write("Usage: io FileRenamer.io <directory> <prefix>\n")
    )
)