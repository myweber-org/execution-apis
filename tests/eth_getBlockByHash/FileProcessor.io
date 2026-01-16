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
        words := content split(" ") select(word, word size > 0)
        uniqueWords := words unique
        result := Map clone
        uniqueWords foreach(word,
            count := words select(w, w == word) size
            result atPut(word, count)
        )
        result
    )

    clearCache := method(
        cache removeAll
        self
    )
)

processor := FileProcessor clone
result := processor process("sample.txt")
result keys sort foreach(key,
    writeln(key, ": ", result at(key))
)
processor clearCache