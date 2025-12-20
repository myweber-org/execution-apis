
FileSystemMonitor := Object clone do(
    init := method(
        self watchedPath := "."
        self changeLog := List clone
    )

    setPath := method(path,
        self watchedPath = path
        self
    )

    checkForChanges := method(
        Directory with(self watchedPath) files foreach(f,
            oldLog := changeLog detect(item, item at("name") == f name)
            currentSize := f size
            if(oldLog,
                if(oldLog at("size") != currentSize,
                    changeLog append(Map clone atPut("name", f name) atPut("size", currentSize))
                    ("File changed: " .. f name) println
                )
            ,
                changeLog append(Map clone atPut("name", f name) atPut("size", currentSize))
                ("New file detected: " .. f name) println
            )
        )
        self
    )

    runMonitor := method(interval,
        while(true,
            self checkForChanges
            wait(interval)
        )
    )
)

monitor := FileSystemMonitor clone setPath("/tmp")
monitor runMonitor(5)