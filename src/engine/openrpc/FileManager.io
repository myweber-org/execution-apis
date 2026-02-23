
FileManager := Object clone do(
    readFile := method(path,
        file := File with(path)
        if(file exists not, return "Error: File not found")
        
        try(
            content := file openForReading contents
            file close
            content
        ) catch(Exception,
            "Error reading file: " .. Exception description
        )
    )
    
    writeFile := method(path, content,
        try(
            file := File with(path) openForUpdating
            file write(content)
            file close
            "File written successfully"
        ) catch(Exception,
            "Error writing file: " .. Exception description
        )
    )
)