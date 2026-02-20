
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
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File with(path) exists not, 
            Exception raise("File not found: #{path}" interpolate)
        )
        
        timestamp := Date clone now asString("%Y%m%d_%H%M%S")
        dir := Path with(path) parentPath
        oldName := Path with(path) fileName
        newName := "#{timestamp}_#{oldName}" interpolate
        newPath := dir appendPath(newName)
        
        File with(path) moveTo(newPath)
        writeln("Renamed: #{oldName} -> #{newName}" interpolate)
        return newPath
    )
    
    renameMultiple := method(paths,
        results := list()
        paths foreach(path,
            try(
                newPath := renameWithTimestamp(path)
                results append(newPath)
            ) catch(Exception,
                writeln("Error: #{exception error}" interpolate)
            )
        )
        return results
    )
)

if(isLaunchScript,
    args := System args slice(1)
    if(args size == 0,
        writeln("Usage: io FileRenamer.io <file1> [file2 ...]")
        exit(1)
    )
    
    FileRenamer renameMultiple(args)
)