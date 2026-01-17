
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
            
            Exception raise("Invalid JSON at position #{idx}" interpolate)
        )
        
        parseObject := method(str, idx,
            obj := Map clone
            while(true,
                // Skip whitespace
                while(str at(idx) isSpace, idx = idx + 1)
                
                // Check for empty object or closing brace
                if(str at(idx) == "}",
                    return list(obj, idx + 1)
                )
                
                // Parse key
                if(str at(idx) != "\"",
                    Exception raise("Expected string key at position #{idx}" interpolate)
                )
                
                keyResult := parseString(str, idx + 1)
                key := keyResult at(0)
                idx = keyResult at(1)
                
                // Skip whitespace and colon
                while(str at(idx) isSpace, idx = idx + 1)
                if(str at(idx) != ":",
                    Exception raise("Expected : at position #{idx}" interpolate)
                )
                idx = idx + 1
                
                // Parse value
                valueResult := parseValue(str, idx)
                value := valueResult at(0)
                idx = valueResult at(1)
                
                obj atPut(key, value)
                
                // Check for comma or closing brace
                while(str at(idx) isSpace, idx = idx + 1)
                if(str at(idx) == "}",
                    return list(obj, idx + 1)
                )
                if(str at(idx) != ",",
                    Exception raise("Expected , or } at position #{idx}" interpolate)
                )
                idx = idx + 1
            )
        )
        
        parseArray := method(str, idx,
            arr := List clone
            while(true,
                // Skip whitespace
                while(str at(idx) isSpace, idx = idx + 1)
                
                // Check for empty array or closing bracket
                if(str at(idx) == "]",
                    return list(arr, idx + 1)
                )
                
                // Parse value
                valueResult := parseValue(str, idx)
                value := valueResult at(0)
                idx = valueResult at(1)
                
                arr append(value)
                
                // Check for comma or closing bracket
                while(str at(idx) isSpace, idx = idx + 1)
                if(str at(idx) == "]",
                    return list(arr, idx + 1)
                )
                if(str at(idx) != ",",
                    Exception raise("Expected , or ] at position #{idx}" interpolate)
                )
                idx = idx + 1
            )
        )
        
        parseString := method(str, idx,
            start := idx
            while(true,
                if(idx >= str size,
                    Exception raise("Unterminated string")
                )
                
                ch := str at(idx)
                if(ch == "\"",
                    return list(str slice(start, idx), idx + 1)
                )
                if(ch == "\\",
                    idx = idx + 1  // Skip escaped character
                )
                idx = idx + 1
            )
        )
        
        parseNumber := method(str, idx,
            start := idx
            while(idx < str size and (str at(idx) isDigit or str at(idx) == "." or str at(idx) == "e" or str at(idx) == "E" or str at(idx) == "-" or str at(idx) == "+"),
                idx = idx + 1
            )
            numStr := str slice(start, idx)
            if(numStr contains("."),
                return list(numStr asNumber, idx)
            )
            return list(numStr asNumber, idx)
        )
        
        result := parseValue(cleanString, 0)
        return result at(0)
    )
    
    stringify := method(obj, pretty := false, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Number", return obj asString)
        if(obj type == "Sequence", return "\"" .. obj .. "\"")
        if(obj type == "Boolean", return if(obj, "true", "false"))
        
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            
            result := "["
            spaces := "  " repeated(indent)
            newline := if(pretty, "\n" .. spaces .. "  ", "")
            separator := if(pretty, ", ", ",")
            
            obj foreach(i, item,
                if(i > 0, result = result .. separator)
                result = result .. newline .. stringify(item, pretty, indent + 1)
            )
            
            if(pretty, result = result .. "\n" .. spaces)
            return result .. "]"
        )
        
        if(obj type == "Map",
            if(obj size == 0, return "{}")
            
            result := "{"
            spaces := "  " repeated(indent)
            newline := if(pretty, "\n" .. spaces .. "  ", "")
            separator := if(pretty, ", ", ",")
            
            keys := obj keys sort
            keys foreach(i, key,
                if(i > 0, result = result .. separator)
                value := obj at(key)
                result = result .. newline .. "\"" .. key .. "\": " .. stringify(value, pretty, indent + 1)
            )
            
            if(pretty, result = result .. "\n" .. spaces)
            return result .. "}"
        )
        
        Exception raise("Cannot stringify type: #{obj type}" interpolate)
    )
    
    prettyPrint := method(obj,
        stringify(obj, true)
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