FileProcessor := Object clone do(
    cache := Map clone
    lazyLoad := method(path,
        if(cache hasKey(path) not,
            cache atPut(path, File with(path) openForReading contents)
        )
        cache at(path)
    )
    
    process := method(path,
        content := lazyLoad(path)
        words := content split(" ") select(w, w size > 0)
        words size
    )
    
    clearCache := method(cache removeAll)
)