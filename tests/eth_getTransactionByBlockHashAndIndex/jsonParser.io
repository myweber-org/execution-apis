
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            doString("(" .. jsonString .. ")")
        ) catch(Exception,
            Exception raise("Invalid JSON: " .. jsonString)
        )
    )
    
    stringify := method(obj, pretty := false,
        if(pretty,
            obj serialized(0)
        ,
            obj serialized
        )
    )
    
    fromFile := method(path,
        file := File with(path) openForReading
        content := file contents
        file close
        parse(content)
    )
    
    toFile := method(obj, path, pretty := false,
        file := File with(path) openForUpdating
        file setContents(stringify(obj, pretty))
        file close
    )
)