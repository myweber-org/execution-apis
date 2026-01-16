
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
            newName := prefix .. counter asString .. extension
            oldPath := directoryPath .. "/" .. file name
            newPath := directoryPath .. "/" .. newName
            
            if(oldPath != newPath,
                file moveTo(newPath)
                writeln("Renamed: ", file name, " -> ", newName)
            )
            counter = counter + 1
        )
        writeln("Renamed ", counter - 1, " files.")
    )
)