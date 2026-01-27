
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            doString("(" .. jsonString .. ")")
        ) catch(e,
            Exception raise("Invalid JSON: " .. e error)
        )
    )
    
    stringify := method(obj, pretty := false,
        if(pretty,
            indent := 0
            format := method(value, level,
                if(value isKindOf(List),
                    if(value isEmpty, return "[]")
                    result := "[\n"
                    indentStr := "  " repeated(level + 1)
                    value foreach(i, v,
                        result = result .. indentStr .. format(v, level + 1)
                        if(i < value size - 1, result = result .. ",")
                        result = result .. "\n"
                    )
                    result = result .. ("  " repeated(level)) .. "]"
                    result
                ) else if(value isKindOf(Map),
                    if(value isEmpty, return "{}")
                    result := "{\n"
                    indentStr := "  " repeated(level + 1)
                    keys := value keys sort
                    keys foreach(i, k,
                        result = result .. indentStr .. "\"" .. k .. "\": " .. 
                                 format(value at(k), level + 1)
                        if(i < keys size - 1, result = result .. ",")
                        result = result .. "\n"
                    )
                    result = result .. ("  " repeated(level)) .. "}"
                    result
                ) else if(value isKindOf(Sequence),
                    "\"" .. value asMutable escape .. "\""
                ) else if(value isKindOf(Number),
                    value asString
                ) else if(value == true, "true") 
                else if(value == false, "false")
                else if(value == nil, "null")
                else "\"" .. value asString asMutable escape .. "\""
            )
            format(obj, 0)
        ,
            // Compact version
            if(obj isKindOf(List),
                "[" .. obj map(stringify) join(",") .. "]"
            ) else if(obj isKindOf(Map),
                "{" .. obj keys map(k, 
                    "\"" .. k .. "\":" .. stringify(obj at(k))
                ) join(",") .. "}"
            ) else if(obj isKindOf(Sequence),
                "\"" .. obj asMutable escape .. "\""
            ) else if(obj isKindOf(Number),
                obj asString
            ) else if(obj == true, "true")
            else if(obj == false, "false")
            else if(obj == nil, "null")
            else "\"" .. obj asString asMutable escape .. "\""
        )
    )
    
    validate := method(jsonString,
        try(
            parse(jsonString)
            true
        ) catch(e,
            false
        )
    )
    
    // Helper method to read JSON from file
    fromFile := method(path,
        parse(File with(path) openForReading contents)
    )
    
    // Helper method to write JSON to file
    toFile := method(obj, path, pretty := false,
        File with(path) openForUpdating setContents(stringify(obj, pretty)) close
    )
)