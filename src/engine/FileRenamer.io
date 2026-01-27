
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File with(path) exists not, return "File not found")
        originalFile := File with(path)
        timestamp := Date clone now asString("%Y%m%d_%H%M%S")
        newPath := path pathComponent splitAt(-1) join("") .. timestamp .. "_" .. path lastPathComponent
        originalFile renameTo(newPath)
        "Renamed #{path} to #{newPath}" interpolate
    )
)

args := System args
if(args size > 1,
    FileRenamer renameWithTimestamp(args at(1)) println,
    "Please provide file path" println
)
FileRenamer := Object clone do(
    renameFilesInDirectory := method(directoryPath,
        directory := Directory with(directoryPath)
        files := directory files map(file, File with(directoryPath .. "/" .. file))
        
        sortedFiles := files sortBy(block(a, b, a lastDataChange < b lastDataChange))
        
        sortedFiles foreach(i, file,
            oldPath := file path
            extension := if(file name containsSeq("."), "." .. file name split(".") last, "")
            baseName := file name beforeSeq(extension)
            newName := "#{i+1} - #{baseName}#{extension}" interpolate
            newPath := directoryPath .. "/" .. newName
            
            if(oldPath != newPath,
                writeln("Renaming: ", file name, " -> ", newName)
                file setPath(newPath)
            )
        )
        
        writeln("Renamed ", sortedFiles size, " files in ", directoryPath)
    )
)

if(isLaunchScript,
    if(System args size == 2,
        FileRenamer renameFilesInDirectory(System args at(1))
    ,
        writeln("Usage: io FileRenamer.io <directory_path>")
    )
)