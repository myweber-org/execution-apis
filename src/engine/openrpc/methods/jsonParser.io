
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            doString("(" .. jsonString .. ")")
        ) catch(
            Exception raise("Invalid JSON format")
        )
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj isKindOf(Number), return obj asString)
        if(obj isKindOf(Sequence), return "\"" .. obj .. "\"")
        if(obj isKindOf(List),
            result := List clone
            obj foreach(i, v,
                result append(stringify(v, indent))
            )
            return "[" .. result join(", ") .. "]"
        )
        if(obj isKindOf(Map),
            result := List clone
            obj foreach(k, v,
                result append("\"" .. k .. "\": " .. stringify(v, indent))
            )
            return "{" .. result join(", ") .. "}"
        )
        Exception raise("Unsupported type for JSON serialization")
    )
    
    prettyPrint := method(obj, indentLevel := 0,
        indent := "  " repeated(indentLevel)
        if(obj isKindOf(Map),
            result := "{\n"
            count := 0
            obj foreach(k, v,
                if(count > 0, result = result .. ",\n")
                result = result .. indent .. "  \"" .. k .. "\": " .. prettyPrint(v, indentLevel + 1)
                count = count + 1
            )
            return result .. "\n" .. indent .. "}"
        )
        if(obj isKindOf(List),
            result := "[\n"
            obj foreach(i, v,
                if(i > 0, result = result .. ",\n")
                result = result .. indent .. "  " .. prettyPrint(v, indentLevel + 1)
            )
            return result .. "\n" .. indent .. "]"
        )
        return stringify(obj)
    )
)

JsonValidator := JsonParser clone do(
    validate := method(jsonString,
        try(
            parse(jsonString)
            true
        ) catch(
            false
        )
    )
    
    validateSchema := method(obj, schema,
        if(schema isKindOf(Map),
            schema foreach(expectedKey, expectedType,
                if(obj hasKey(expectedKey) not,
                    return false
                )
                actualValue := obj at(expectedKey)
                if(expectedType == "string" and actualValue isKindOf(Sequence) not,
                    return false
                )
                if(expectedType == "number" and actualValue isKindOf(Number) not,
                    return false
                )
                if(expectedType == "boolean" and (actualValue == true or actualValue == false) not,
                    return false
                )
                if(expectedType == "array" and actualValue isKindOf(List) not,
                    return false
                )
                if(expectedType == "object" and actualValue isKindOf(Map) not,
                    return false
                )
            )
        )
        true
    )
)