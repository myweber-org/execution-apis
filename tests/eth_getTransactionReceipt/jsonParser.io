
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            doString("(" .. jsonString .. ")")
        ) catch(
            Exception raise("Invalid JSON format")
        )
    )
    
    stringify := method(obj, pretty := false,
        if(pretty,
            obj serialized,
            obj asJson
        )
    )
    
    validate := method(jsonString,
        try(
            parse(jsonString)
            true
        ) catch(
            false
        )
    )
    
    prettyPrint := method(jsonString,
        obj := parse(jsonString)
        stringify(obj, true)
    )
)