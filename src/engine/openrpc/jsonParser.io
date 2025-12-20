
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
        obj := parse(jsonString)
        stringify(obj, true)
    )
)