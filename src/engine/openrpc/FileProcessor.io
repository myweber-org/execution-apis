
FileProcessor := Object clone do(
    _files := Map clone

    loadFile := method(path,
        if(_files at(path) isNil,
            try(
                file := File with(path)
                if(file exists not, return nil)
                content := file read
                _files atPut(path, content)
                content
            ) catch(Exception,
                writeln("Error loading file: ", path)
                nil
            )
        ,
            _files at(path)
        )
    )

    clearCache := method(
        _files empty
        self
    )

    getStats := method(
        stats := Map clone
        stats atPut("cachedFiles", _files size)
        stats atPut("totalSize", _files values map(size) sum)
        stats
    )
)