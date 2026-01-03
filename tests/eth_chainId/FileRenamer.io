
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