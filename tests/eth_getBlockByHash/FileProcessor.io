FileProcessor := Object clone do(
    cache := Map clone
    lazyLoad := method(filename,
        if(cache hasKey(filename) not,
            cache atPut(filename, File with(filename) openForReading contents)
        )
        cache at(filename)
    )
    
    process := method(filename,
        content := lazyLoad(filename)
        words := content split(" ") select(word, word size > 0)
        uniqueWords := words unique
        Map clone atPut("total", words size) atPut("unique", uniqueWords size)
    )
    
    clearCache := method(cache empty)
)