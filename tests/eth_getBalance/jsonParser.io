
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty,
            Exception raise("Empty JSON string")
        )
        
        try(
            doString("(" .. jsonString .. ")")
        ) catch(e,
            Exception raise("Invalid JSON: " .. e error)
        )
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        
        if(obj type == "Sequence",
            return "\"" .. obj asMutable escape .. "\""
        )
        
        if(obj type == "Number",
            return obj asString
        )
        
        if(obj type == "List",
            result := List clone
            obj foreach(i, v,
                result append(stringify(v, indent))
            )
            return "[" .. result join(", ") .. "]"
        )
        
        if(obj type == "Map",
            result := List clone
            obj keys sort foreach(k,
                result append("\"" .. k .. "\": " .. stringify(obj at(k), indent))
            )
            return "{" .. result join(", ") .. "}"
        )
        
        if(obj type == "True" or obj type == "False",
            return obj asString
        )
        
        Exception raise("Unsupported type: " .. obj type)
    )
    
    prettyPrint := method(obj, indentLevel := 0,
        spaces := "  " repeated(indentLevel)
        
        if(obj isNil, return spaces .. "null")
        
        if(obj type == "Sequence",
            return spaces .. "\"" .. obj asMutable escape .. "\""
        )
        
        if(obj type == "Number" or obj type == "True" or obj type == "False",
            return spaces .. obj asString
        )
        
        if(obj type == "List",
            if(obj isEmpty, return spaces .. "[]")
            
            result := List clone
            result append(spaces .. "[")
            obj foreach(i, v,
                result append(prettyPrint(v, indentLevel + 1))
            )
            result append(spaces .. "]")
            return result join(",\n")
        )
        
        if(obj type == "Map",
            if(obj isEmpty, return spaces .. "{}")
            
            result := List clone
            result append(spaces .. "{")
            obj keys sort foreach(k,
                valueStr := prettyPrint(obj at(k), indentLevel + 1)
                result append(spaces .. "  \"" .. k .. "\": " .. valueStr split("\n") first)
                if(valueStr contains("\n"),
                    result append(valueStr split("\n") rest map(line, spaces .. "  " .. line) join("\n"))
                )
            )
            result append(spaces .. "}")
            return result join(",\n")
        )
        
        Exception raise("Unsupported type: " .. obj type)
    )
)