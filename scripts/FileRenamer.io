
FileRenamer := Object clone do(
    renameWithTimestamp := method(path,
        if(File exists(path),
            originalFile := File with(path)
            timestamp := Date clone now asString("%Y%m%d_%H%M%S")
            extension := originalFile path pathExtension
            baseName := originalFile path fileNameWithoutExtension
            newPath := originalFile path pathDirectory .. "/" .. timestamp .. "_" .. baseName .. "." .. extension
            
            if(originalFile exists not,
                return "File does not exist: #{path}" interpolate
            )
            
            originalFile moveTo(newPath)
            return "Renamed to: #{newPath}" interpolate
        ,
            return "Invalid file path: #{path}" interpolate
        )
    )
)