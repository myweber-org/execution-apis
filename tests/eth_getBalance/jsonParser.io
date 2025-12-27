
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
            obj serialized
        ,
            obj asJson
        )
    )
    
    prettyPrint := method(jsonString,
        parsed := parse(jsonString)
        stringify(parsed, true)
    )
    
    validate := method(jsonString,
        try(
            parse(jsonString)
            true
        ) catch(Exception,
            false
        )
    )
)