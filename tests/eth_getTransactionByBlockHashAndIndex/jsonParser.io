
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
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty,
            Exception raise("Empty JSON string")
        )
        
        // Remove whitespace
        cleanString := jsonString asMutable strip
        
        // Validate basic structure
        if(cleanString at(0) != "{" and cleanString at(0) != "[",
            Exception raise("Invalid JSON: must start with { or [")
        )
        
        // Simple JSON parser implementation
        parseValue := method(str, idx,
            currentChar := str at(idx)
            
            if(currentChar == "{",
                return parseObject(str, idx + 1)
            )
            if(currentChar == "[",
                return parseArray(str, idx + 1)
            )
            if(currentChar == "\"",
                return parseString(str, idx + 1)
            )
            if(currentChar isDigit or currentChar == "-",
                return parseNumber(str, idx)
            )
            if(str slice(idx, idx + 4) == "true",
                return list(true, idx + 4)
            )
            if(str slice(idx, idx + 5) == "false",
                return list(false, idx + 5)
            )
            if(str slice(idx, idx + 4) == "null",
                return list(nil, idx + 4)
            )
            
            Exception raise("Invalid JSON value at position #{idx}" interpolate)
        )
        
        parseObject := method(str, idx,
            obj := Map clone
            skipWhitespace(str, idx) setSlot("idx", idx)
            
            while(str at(idx) != "}",
                // Parse key
                if(str at(idx) != "\"",
                    Exception raise("Expected string key at position #{idx}" interpolate)
                )
                keyResult := parseString(str, idx + 1)
                key := keyResult at(0)
                idx := keyResult at(1)
                
                skipWhitespace(str, idx) setSlot("idx", idx)
                
                // Expect colon
                if(str at(idx) != ":",
                    Exception raise("Expected : at position #{idx}" interpolate)
                )
                idx := idx + 1
                skipWhitespace(str, idx) setSlot("idx", idx)
                
                // Parse value
                valueResult := parseValue(str, idx)
                value := valueResult at(0)
                idx := valueResult at(1)
                
                obj atPut(key, value)
                
                skipWhitespace(str, idx) setSlot("idx", idx)
                
                // Check for comma or closing brace
                if(str at(idx) == ",",
                    idx := idx + 1
                    skipWhitespace(str, idx) setSlot("idx", idx)
                ) elseif(str at(idx) != "}",
                    Exception raise("Expected , or } at position #{idx}" interpolate)
                )
            )
            
            return list(obj, idx + 1)
        )
        
        parseArray := method(str, idx,
            arr := List clone
            skipWhitespace(str, idx) setSlot("idx", idx)
            
            while(str at(idx) != "]",
                valueResult := parseValue(str, idx)
                value := valueResult at(0)
                idx := valueResult at(1)
                
                arr append(value)
                
                skipWhitespace(str, idx) setSlot("idx", idx)
                
                if(str at(idx) == ",",
                    idx := idx + 1
                    skipWhitespace(str, idx) setSlot("idx", idx)
                ) elseif(str at(idx) != "]",
                    Exception raise("Expected , or ] at position #{idx}" interpolate)
                )
            )
            
            return list(arr, idx + 1)
        )
        
        parseString := method(str, idx,
            start := idx
            while(str at(idx) != "\"",
                if(str at(idx) == "\\",
                    idx := idx + 1  // Skip escaped character
                )
                idx := idx + 1
            )
            return list(str slice(start, idx), idx + 1)
        )
        
        parseNumber := method(str, idx,
            start := idx
            while(str at(idx) isDigit or str at(idx) == "." or 
                  str at(idx) == "e" or str at(idx) == "E" or
                  str at(idx) == "+" or str at(idx) == "-",
                idx := idx + 1
            )
            numStr := str slice(start, idx)
            return list(numStr asNumber, idx)
        )
        
        skipWhitespace := method(str, idx,
            while(idx < str size and (str at(idx) == " " or 
                                      str at(idx) == "\t" or
                                      str at(idx) == "\n" or
                                      str at(idx) == "\r"),
                idx := idx + 1
            )
            return idx
        )
        
        result := parseValue(cleanString, 0)
        return result at(0)
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Number", return obj asString)
        if(obj type == "Sequence", return "\"" .. obj .. "\"")
        if(obj type == "Boolean", return if(obj, "true", "false"))
        
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            
            result := "["
            spaces := " " repeated(indent + 2)
            
            obj foreach(i, item,
                if(i > 0, result = result .. ",")
                result = result .. "\n" .. spaces .. stringify(item, indent + 2)
            )
            
            return result .. "\n" .. " " repeated(indent) .. "]"
        )
        
        if(obj type == "Map",
            if(obj isEmpty, return "{}")
            
            result := "{"
            spaces := " " repeated(indent + 2)
            keys := obj keys
            
            keys foreach(i, key,
                if(i > 0, result = result .. ",")
                value := obj at(key)
                result = result .. "\n" .. spaces .. "\"" .. key .. "\": " .. 
                        stringify(value, indent + 2)
            )
            
            return result .. "\n" .. " " repeated(indent) .. "}"
        )
        
        Exception raise("Cannot stringify object of type #{obj type}" interpolate)
    )
    
    validate := method(jsonString,
        try(
            parse(jsonString)
            return true
        ) catch(Exception,
            return false
        )
    )
    
    prettyPrint := method(jsonString,
        parsed := parse(jsonString)
        return stringify(parsed, 0)
    )
)