
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            jsonString asMutable replaceSeq("\"", "\"") asJson
        ) catch(Exception,
            Exception raise("Invalid JSON string: " .. jsonString)
        )
    )
    
    stringify := method(obj,
        obj asJson
    )
)