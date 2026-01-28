
FileRenamer := Object clone do(
    renameFiles := method(directoryPath, oldPattern, newPattern,
        directory := Directory with(directoryPath)
        if(directory isNil, return "Directory not found.")

        files := directory files select(name containsSeq(oldPattern))
        files foreach(file,
            newName := file name asMutable replaceSeq(oldPattern, newPattern)
            oldPath := directoryPath .. "/" .. file name
            newPath := directoryPath .. "/" .. newName
            File rename(oldPath, newPath)
            writeln("Renamed '", file name, "' to '", newName, "'")
        )
        "Renaming complete." println
    )
)

// Example usage (commented out)
// FileRenamer renameFiles(".", "temp_", "archive_")