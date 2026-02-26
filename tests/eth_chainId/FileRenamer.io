
FileRenamer := Object clone do(
    renameFiles := method(path, prefix,
        directory := Directory with(path)
        directory fileNames foreach(i, fileName,
            oldPath := path .. "/" .. fileName
            newPath := path .. "/" .. prefix .. fileName
            if(File clone with(oldPath) exists,
                File clone with(oldPath) renameTo(newPath)
                writeln("Renamed: ", fileName, " -> ", prefix .. fileName)
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
    renameFilesInDirectory := method(directoryPath,
        directory := Directory with(directoryPath)
        files := directory files map(file,
            Map clone atPut("path", file path) atPut("modified", file modified)
        ) sortBy("modified")

        counter := 1
        files foreach(fileInfo,
            oldPath := fileInfo at("path")
            extension := PathExtension with(oldPath)
            newName := "#{counter}.#{extension}" interpolate
            newPath := Path with(directoryPath, newName) asString

            if(File clone with(oldPath) renameTo(newPath),
                "Renamed: #{oldPath} -> #{newPath}" interpolate println,
                "Failed to rename: #{oldPath}" interpolate println
            )
            counter = counter + 1
        )
    )
)

if(isLaunchScript,
    if(System args size == 1,
        FileRenamer renameFilesInDirectory(System args at(0)),
        "Usage: #{System args at(0)} <directory>" interpolate println
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
            newName := prefix .. counter asString .. extension
            oldPath := directoryPath .. "/" .. file name
            newPath := directoryPath .. "/" .. newName
            
            if(oldPath != newPath,
                File rename(oldPath, newPath)
                writeln("Renamed: ", file name, " -> ", newName)
            )
            counter = counter + 1
        )
        writeln("Renaming complete. Processed ", counter - 1, " files.")
    )
)

if(isLaunchScript,
    if(System args size == 3,
        FileRenamer renameFiles(System args at(1), System args at(2))
    ,
        writeln("Usage: io FileRenamer.io <directory> <prefix>")
    )
)