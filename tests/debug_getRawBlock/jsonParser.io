
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty, 
            return Exception raise("Empty JSON string")
        )
        
        try(
            doString("(" .. jsonString .. ")")
        ) catch(e,
            Exception raise("Invalid JSON: " .. e error)
        )
    )
    
    stringify := method(obj, pretty := false,
        if(obj isNil, return "null")
        
        if(obj type == "Map",
            items := list()
            obj foreach(key, value,
                items append("\"" .. key .. "\": " .. stringify(value, pretty))
            )
            if(pretty,
                "{\n  " .. items join(",\n  ") .. "\n}"
            ,
                "{" .. items join(", ") .. "}"
            )
        ) else if(obj type == "List",
            items := obj map(v, stringify(v, pretty))
            if(pretty,
                "[\n  " .. items join(",\n  ") .. "\n]"
            ,
                "[" .. items join(", ") .. "]"
            )
        ) else if(obj type == "Sequence",
            "\"" .. obj asMutable escape .. "\""
        ) else if(obj type == "Number",
            obj asString
        ) else if(obj type == "Nil",
            "null"
        ) else if(obj type == "True" or obj type == "False",
            obj asString
        ) else (
            Exception raise("Unsupported type: " .. obj type)
        )
    )
    
    prettyPrint := method(obj,
        writeln(stringify(obj, true))
    )
)