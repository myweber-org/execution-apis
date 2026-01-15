
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
                return parseObject(str, idx)
            )
            if(currentChar == "[",
                return parseArray(str, idx)
            )
            if(currentChar == "\"",
                return parseString(str, idx)
            )
            if(currentChar isDigit or currentChar == "-",
                return parseNumber(str, idx)
            )
            if(str slice(idx, idx+4) == "true",
                return list(true, idx+4)
            )
            if(str slice(idx, idx+5) == "false",
                return list(false, idx+5)
            )
            if(str slice(idx, idx+4) == "null",
                return list(nil, idx+4)
            )
            
            Exception raise("Invalid JSON value at position #{idx}" interpolate)
        )
        
        parseObject := method(str, idx,
            obj := Map clone
            idx = idx + 1
            
            while(idx < str size,
                // Skip whitespace
                while(str at(idx) isSpace, idx = idx + 1)
                
                if(str at(idx) == "}",
                    return list(obj, idx + 1)
                )
                
                // Parse key
                result := parseString(str, idx)
                key := result at(0)
                idx = result at(1)
                
                // Skip whitespace and colon
                while(str at(idx) isSpace, idx = idx + 1)
                if(str at(idx) != ":",
                    Exception raise("Expected colon after key")
                )
                idx = idx + 1
                
                // Parse value
                result = parseValue(str, idx)
                value := result at(0)
                idx = result at(1)
                
                obj atPut(key, value)
                
                // Check for comma or closing brace
                while(str at(idx) isSpace, idx = idx + 1)
                if(str at(idx) == ",",
                    idx = idx + 1
                )
            )
            
            Exception raise("Unterminated object")
        )
        
        parseArray := method(str, idx,
            arr := List clone
            idx = idx + 1
            
            while(idx < str size,
                // Skip whitespace
                while(str at(idx) isSpace, idx = idx + 1)
                
                if(str at(idx) == "]",
                    return list(arr, idx + 1)
                )
                
                // Parse value
                result := parseValue(str, idx)
                value := result at(0)
                idx = result at(1)
                
                arr append(value)
                
                // Check for comma or closing bracket
                while(str at(idx) isSpace, idx = idx + 1)
                if(str at(idx) == ",",
                    idx = idx + 1
                )
            )
            
            Exception raise("Unterminated array")
        )
        
        parseString := method(str, idx,
            idx = idx + 1  // Skip opening quote
            start := idx
            result := Sequence clone
            
            while(idx < str size,
                ch := str at(idx)
                
                if(ch == "\\",
                    idx = idx + 1
                    if(idx >= str size,
                        Exception raise("Unterminated escape sequence")
                    )
                    
                    nextChar := str at(idx)
                    if(nextChar == "\"", result append("\""))
                    if(nextChar == "\\", result append("\\"))
                    if(nextChar == "/", result append("/"))
                    if(nextChar == "b", result append("\b"))
                    if(nextChar == "f", result append("\f"))
                    if(nextChar == "n", result append("\n"))
                    if(nextChar == "r", result append("\r"))
                    if(nextChar == "t", result append("\t"))
                    // TODO: Add unicode escape support
                ,
                    if(ch == "\"",
                        return list(result, idx + 1)
                    )
                    result append(ch)
                )
                
                idx = idx + 1
            )
            
            Exception raise("Unterminated string")
        )
        
        parseNumber := method(str, idx,
            start := idx
            
            // Handle negative sign
            if(str at(idx) == "-",
                idx = idx + 1
            )
            
            // Parse integer part
            while(idx < str size and str at(idx) isDigit,
                idx = idx + 1
            )
            
            // Parse fractional part
            if(idx < str size and str at(idx) == ".",
                idx = idx + 1
                while(idx < str size and str at(idx) isDigit,
                    idx = idx + 1
                )
            )
            
            // Parse exponent
            if(idx < str size and (str at(idx) == "e" or str at(idx) == "E"),
                idx = idx + 1
                if(idx < str size and (str at(idx) == "+" or str at(idx) == "-"),
                    idx = idx + 1
                )
                while(idx < str size and str at(idx) isDigit,
                    idx = idx + 1
                )
            )
            
            numberStr := str slice(start, idx)
            number := numberStr asNumber
            
            return list(number, idx)
        )
        
        result := parseValue(cleanString, 0)
        return result at(0)
    )
    
    prettyPrint := method(parsedObject, indentLevel := 0,
        indent := "  " repeated(indentLevel)
        
        if(parsedObject type == "Map",
            result := "{\n"
            count := 0
            parsedObject foreach(key, value,
                result = result .. indent .. "  \"#{key}\": " interpolate
                result = result .. prettyPrint(value, indentLevel + 1)
                count = count + 1
                if(count < parsedObject size,
                    result = result .. ","
                )
                result = result .. "\n"
            )
            result = result .. indent .. "}"
            return result
        )
        
        if(parsedObject type == "List",
            result := "[\n"
            count := 0
            parsedObject foreach(value,
                result = result .. indent .. "  " .. prettyPrint(value, indentLevel + 1)
                count = count + 1
                if(count < parsedObject size,
                    result = result .. ","
                )
                result = result .. "\n"
            )
            result = result .. indent .. "]"
            return result
        )
        
        if(parsedObject type == "Sequence",
            return "\"#{parsedObject}\"" interpolate
        )
        
        if(parsedObject type == "Number",
            return parsedObject asString
        )
        
        if(parsedObject type == "True" or parsedObject type == "False",
            return parsedObject asString
        )
        
        if(parsedObject isNil,
            return "null"
        )
        
        return "unknown"
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