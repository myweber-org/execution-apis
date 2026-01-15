
FileRenamer := Object clone do(
    renameFilesInDirectory := method(directoryPath,
        files := Directory with(directoryPath) files
        sortedFiles := files sortBy(block(a, b, a lastDataChange < b lastDataChange))
        
        counter := 1
        sortedFiles foreach(file,
            extension := file path pathExtension
            newName := directoryPath .. "/" .. counter asString .. extension
            if(file path != newName,
                file moveTo(newName)
                ("Renamed: " .. file path .. " -> " .. newName) println
            )
            counter = counter + 1
        )
        ("Total files processed: " .. (counter - 1)) println
    )
)

if(isLaunchScript,
    if(System args size > 1,
        FileRenamer renameFilesInDirectory(System args at(1))
    ,
        "Usage: io FileRenamer.io <directory_path>" println
    )
)
FileRenamer := Object clone do(
    renameFilesInDirectory := method(directoryPath,
        files := Directory with(directoryPath) files
        sortedFiles := files sortBy(block(a, b, a lastDataChange > b lastDataChange))
        
        counter := 1
        sortedFiles foreach(file,
            extension := if(file name containsSeq("."), 
                "." .. file name split(".") last, 
                ""
            )
            newName := directoryPath .. "/" .. counter asString(100) .. extension
            if(file path != newName,
                file moveTo(newName)
                write("Renamed: ", file name, " -> ", counter asString(100), extension, "\n")
            )
            counter = counter + 1
        )
        write("Total files processed: ", (counter - 1), "\n")
    )
)

if(isLaunchScript,
    if(System args size > 1,
        FileRenamer renameFilesInDirectory(System args at(1))
    ,
        write("Usage: io FileRenamer.io <directory_path>\n")
    )
)