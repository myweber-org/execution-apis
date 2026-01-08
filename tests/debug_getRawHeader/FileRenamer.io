
FileRenamer := Object clone
FileRenamer rename := method(path, newName,
    files := Directory with(path) files
    files foreach(i, file,
        extension := file path split(".") last
        newPath := path .. "/" .. newName .. (i+1) .. "." .. extension
        file moveTo(newPath)
        write("Renamed ", file name, " to ", newPath split("/") last, "\n")
    )
)

if(isLaunchScript,
    FileRenamer rename(System args at(1), System args at(2))
)