
FileRenamer := Object clone do(
    renameFiles := method(path, prefix,
        directory := Directory with(path)
        directory files foreach(i, file,
            oldPath := file path
            if(file isDirectory not,
                newName := prefix .. file name
                newPath := path pathComponent(newName)
                file renameTo(newPath)
                writeln("Renamed: ", oldPath, " -> ", newPath)
            )
        )
    )
)

if(isLaunchScript,
    if(System args size >= 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        writeln("Usage: io FileRenamer.io <directory_path> <prefix>")
    )
)
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, prefix,
        files := Directory with(directoryPath) files
        counter := 1
        files foreach(i, file,
            if(file name endsWithSeq(".txt"),
                newName := prefix .. counter .. ".txt"
                oldPath := directoryPath .. "/" .. file name
                newPath := directoryPath .. "/" .. newName
                File rename(oldPath, newPath)
                ("Renamed: " .. file name .. " -> " .. newName) println
                counter = counter + 1
            )
        )
        ("Total files renamed: " .. (counter - 1)) println
    )
)

if(isLaunchScript,
    FileRenamer renameFiles("documents", "document_")
)