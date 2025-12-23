
FileRenamer := Object clone do(
    renameFiles := method(directory, prefix, startNumber,
        files := Directory with(directory) files
        files sortBy(createdAt)
        
        counter := startNumber
        files foreach(file,
            extension := if(file name containsSeq("."), 
                "." .. (file name split(".") last), 
                ""
            )
            newName := prefix .. counter .. extension
            oldPath := directory .. "/" .. file name
            newPath := directory .. "/" .. newName
            
            if(File clone with(oldPath) exists,
                File clone with(oldPath) renameTo(newPath)
                write("Renamed: ", oldPath, " -> ", newName, "\n")
                counter = counter + 1
            )
        )
        write("Total files renamed: ", counter - startNumber, "\n")
    )
)

if(isLaunchScript,
    if(System args size >= 3,
        directory := System args at(1)
        prefix := System args at(2)
        startNumber := if(System args size >= 4, 
            System args at(3) asNumber, 
            1
        )
        
        if(Directory with(directory) exists,
            FileRenamer renameFiles(directory, prefix, startNumber)
        ,
            write("Directory not found: ", directory, "\n")
        )
    ,
        write("Usage: io FileRenamer.io <directory> <prefix> [startNumber]\n")
    )
)