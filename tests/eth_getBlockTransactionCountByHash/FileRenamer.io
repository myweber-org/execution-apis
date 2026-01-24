
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        files sortByKey("name")
        counter := 1
        files foreach(i, file,
            extension := file name split(".") last
            newName := "#{prefix}#{counter}.#{extension}" interpolate
            oldPath := file path
            newPath := Path with(directoryPath) appendPath(newName)
            if(oldPath != newPath,
                file moveTo(newPath)
                writeln("Renamed: ", oldPath, " -> ", newPath)
            )
            counter = counter + 1
        )
        writeln("Renamed ", files size, " files.")
    )
)
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        sortedFiles := files sortBy(block(a, b, a name < b name))
        counter := 1
        
        sortedFiles foreach(file,
            extension := if(file name containsSeq("."), 
                "." .. file name split(".") last, 
                ""
            )
            newName := prefix .. counter asString(100) .. extension
            oldPath := directoryPath .. "/" .. file name
            newPath := directoryPath .. "/" .. newName
            
            if(File clone with(oldPath) exists,
                File clone with(oldPath) renameTo(newPath)
                ("Renamed: " .. file name .. " -> " .. newName) println
                counter = counter + 1
            )
        )
        ("Total files renamed: " .. (counter - 1)) println
    )
)

if(isLaunchScript,
    if(System args size == 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        "Usage: io FileRenamer.io <directory> <prefix>" println
    )
)