
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File with(path) exists not, return "File not found")
        
        originalFile := File with(path)
        timestamp := Date clone now asNumber asString
        newPath := path pathComponent splitAt(-1) appendSeq(list(timestamp, path pathComponent last)) join("_")
        
        originalFile setPath(newPath)
        if(originalFile exists, return "Renamed to: #{newPath}" interpolate, return "Rename failed")
    )
    
    batchRename := method(directoryPath, extension,
        Directory with(directoryPath) files select(f, f path endsWith(extension)) foreach(f,
            renameWithTimestamp(f path) println
        )
    )
)

if(isLaunchScript,
    if(System args size >= 2,
        FileRenamer renameWithTimestamp(System args at(1)) println
    )
)