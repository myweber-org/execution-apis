
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