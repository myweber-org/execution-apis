
FileProcessor := Object clone do(
    init := method(
        self cache := Map clone
        self loaded := false
    )

    loadFile := method(path,
        if(cache hasKey(path) not,
            cache atPut(path, File with(path) openForReading contents)
        )
        cache at(path)
    )

    lazyLoad := method(path,
        if(loaded not,
            self loaded = true
            self loadFile(path)
        )
    )

    clearCache := method(
        cache removeAll
        self loaded = false
    )
)

processor := FileProcessor clone
processor lazyLoad("data.txt")
processor loadFile("config.ini")
processor clearCache