
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File exists(path),
            originalFile := File with(path)
            timestamp := Date clone now asString("%Y%m%d_%H%M%S")
            extension := originalFile name split(".") last
            baseName := originalFile name split(".") slice(0, -1) join(".")
            newName := timestamp .. "_" .. baseName .. "." .. extension
            newPath := originalFile parentPath .. "/" .. newName
            
            originalFile moveTo(newPath)
            writeln("Renamed: ", path, " -> ", newPath)
            return newPath
        ,
            writeln("File not found: ", path)
            return nil
        )
    )
)

if(isLaunchScript,
    args := System args
    if(args size > 1,
        FileRenamer renameWithTimestamp(args at(1))
    ,
        writeln("Usage: io FileRenamer.io <filename>")
    )
)