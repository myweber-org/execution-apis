
FileRenamer := Object clone do(
    renameFilesInDirectory := method(directoryPath,
        files := Directory with(directoryPath) files
        sortedFiles := files sortBy(block(a, b, a lastDataChange > b lastDataChange))
        
        counter := 1
        sortedFiles foreach(file,
            extension := file path pathExtension
            newName := directoryPath .. "/" .. counter asString .. extension
            file moveTo(newName)
            "Renamed #{file name} to #{counter}#{extension}" interpolate println
            counter = counter + 1
        )
    )
)

if(isLaunchScript,
    if(System args size > 1,
        FileRenamer renameFilesInDirectory(System args at(1))
    ,
        "Usage: io FileRenamer.io <directory_path>" println
    )
)