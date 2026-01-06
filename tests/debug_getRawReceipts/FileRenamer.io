
FileRenamer := Object clone do(
    renameWithTimestamp := method(filePath,
        if(filePath isNil or filePath asString isEmpty,
            Exception raise("File path cannot be empty")
        )
        
        originalFile := File with(filePath)
        if(originalFile exists not,
            Exception raise("File does not exist: #{filePath}" interpolate)
        )
        
        timestamp := Date clone now asNumber floor
        extension := originalFile path extension
        baseName := originalFile nameWithoutExtension
        
        newName := "#{timestamp}_#{baseName}#{extension}" interpolate
        newPath := originalFile directory path / newName
        
        originalFile renameTo(newPath)
        newPath
    )
)