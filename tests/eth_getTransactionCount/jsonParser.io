
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty, return nil)
        
        // Remove whitespace
        cleanString := jsonString asMutable strip
        
        // Validate basic structure
        if(cleanString beginsWithSeq("{") not and cleanString beginsWithSeq("[") not,
            Exception raise("Invalid JSON: must start with { or [")
        )
        
        // Simple JSON parser implementation
        parseValue := method(str,
            str = str asMutable strip
            
            if(str beginsWithSeq("{"),
                return parseObject(str)
            )
            
            if(str beginsWithSeq("["),
                return parseArray(str)
            )
            
            if(str beginsWithSeq("\""),
                return parseString(str)
            )
            
            if(str beginsWithSeq("true"), return true)
            if(str beginsWithSeq("false"), return false)
            if(str beginsWithSeq("null"), return nil)
            
            // Try parsing as number
            if(str containsSeq("."),
                return str asNumber
            )
            
            str asNumber
        )
        
        parseObject := method(str,
            result := Map clone
            str = str exSlice(1, str size - 1) // Remove braces
            fields := str split(",")
            
            fields foreach(field,
                field = field strip
                if(field isEmpty, continue)
                
                parts := field split(":")
                if(parts size != 2,
                    Exception raise("Invalid object field: " .. field)
                )
                
                key := parseString(parts at(0) strip)
                value := parseValue(parts at(1) strip)
                result atPut(key, value)
            )
            
            result
        )
        
        parseArray := method(str,
            result := List clone
            str = str exSlice(1, str size - 1) // Remove brackets
            if(str isEmpty, return result)
            
            elements := str split(",")
            elements foreach(element,
                element = element strip
                if(element isEmpty, continue)
                result append(parseValue(element))
            )
            
            result
        )
        
        parseString := method(str,
            str = str exSlice(1, str size - 1) // Remove quotes
            str replace("\"", "\"") // Unescape quotes
        )
        
        parseValue(cleanString)
    )
    
    stringify := method(obj, pretty := false,
        if(obj isNil, return "null")
        
        if(obj type == "Map",
            result := List clone
            obj foreach(key, value,
                jsonKey := "\"" .. key .. "\""
                jsonValue := stringify(value, pretty)
                result append(jsonKey .. ":" .. jsonValue)
            )
            
            if(pretty,
                return "{\n  " .. result join(",\n  ") .. "\n}"
            )
            
            return "{" .. result join(",") .. "}"
        )
        
        if(obj type == "List",
            result := List clone
            obj foreach(value,
                result append(stringify(value, pretty))
            )
            
            if(pretty,
                return "[\n  " .. result join(",\n  ") .. "\n]"
            )
            
            return "[" .. result join(",") .. "]"
        )
        
        if(obj type == "Sequence",
            escaped := obj clone
            escaped replace("\"", "\\\"")
            return "\"" .. escaped .. "\""
        )
        
        if(obj type == "Number",
            return obj asString
        )
        
        if(obj type == "true" or obj type == "false",
            return obj asString
        )
        
        Exception raise("Unsupported type for JSON serialization: " .. obj type)
    )
    
    validate := method(jsonString,
        try(
            parse(jsonString)
            return true
        ) catch(Exception,
            return false
        )
    )
)