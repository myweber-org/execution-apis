
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
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty,
            Exception raise("Empty JSON string")
        )
        
        // Remove whitespace
        jsonString := jsonString strip
        
        // Parse based on first character
        if(jsonString beginsWithSeq("{"),
            parseObject(jsonString)
        elseif(jsonString beginsWithSeq("["),
            parseArray(jsonString)
        elseif(jsonString beginsWithSeq("\""),
            parseString(jsonString)
        elseif(jsonString asLowercase == "true",
            true
        elseif(jsonString asLowercase == "false",
            false
        elseif(jsonString asLowercase == "null",
            nil
        elseif(jsonString containsSeq("."),
            jsonString asNumber
        else,
            jsonString asNumber
        )
    )
    
    parseObject := method(jsonString,
        result := Map clone
        content := jsonString slice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content size > 0,
            // Find key
            keyStart := content findSeq("\"")
            if(keyStart == -1, Exception raise("Invalid object: missing key"))
            
            keyEnd := content findSeq("\"", keyStart + 1)
            if(keyEnd == -1, Exception raise("Invalid object: unclosed key"))
            
            key := content slice(keyStart + 1, keyEnd)
            content = content slice(keyEnd + 1) strip
            
            // Find colon
            if(content beginsWithSeq(":") not,
                Exception raise("Invalid object: missing colon after key")
            )
            content = content slice(1) strip
            
            // Find value
            valueEnd := findValueEnd(content)
            valueStr := content slice(0, valueEnd)
            value := parse(valueStr)
            
            result atPut(key, value)
            
            // Move to next pair or end
            content = content slice(valueEnd) strip
            if(content beginsWithSeq(","),
                content = content slice(1) strip
            )
        )
        
        result
    )
    
    parseArray := method(jsonString,
        result := List clone
        content := jsonString slice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content size > 0,
            valueEnd := findValueEnd(content)
            valueStr := content slice(0, valueEnd)
            value := parse(valueStr)
            
            result append(value)
            
            content = content slice(valueEnd) strip
            if(content beginsWithSeq(","),
                content = content slice(1) strip
            )
        )
        
        result
    )
    
    parseString := method(jsonString,
        // Remove quotes and handle escapes
        content := jsonString slice(1, -1)
        content replaceSeq("\\\"", "\"") replaceSeq("\\\\", "\\")
    )
    
    findValueEnd := method(str,
        str = str strip
        if(str beginsWithSeq("{"),
            findMatchingBrace(str, "{", "}")
        elseif(str beginsWithSeq("["),
            findMatchingBrace(str, "[", "]")
        elseif(str beginsWithSeq("\""),
            findStringEnd(str)
        else,
            findSimpleValueEnd(str)
        )
    )
    
    findMatchingBrace := method(str, open, close,
        count := 1
        i := 1
        while(i < str size and count > 0,
            if(str at(i) asCharacter == open,
                count = count + 1
            elseif(str at(i) asCharacter == close,
                count = count - 1
            elseif(str at(i) asCharacter == "\"" and str at(i-1) asCharacter != "\\",
                // Skip strings
                stringEnd := findStringEnd(str slice(i))
                i = i + stringEnd - 1
            )
            i = i + 1
        )
        i
    )
    
    findStringEnd := method(str,
        i := 1
        while(i < str size,
            if(str at(i) asCharacter == "\"" and str at(i-1) asCharacter != "\\",
                return i + 1
            )
            i = i + 1
        )
        Exception raise("Unclosed string")
    )
    
    findSimpleValueEnd := method(str,
        commaPos := str findSeq(",")
        endPos := str findSeq("}")
        bracketPos := str findSeq("]")
        
        positions := list(commaPos, endPos, bracketPos) select(pos != -1)
        if(positions isEmpty, return str size)
        
        positions min
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Boolean", return if(obj, "true", "false"))
        if(obj type == "Number", return obj asString)
        if(obj type == "Sequence", return "\"" .. obj .. "\"")
        
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            
            result := "[\n"
            obj foreach(i, item,
                result = result .. ("  " repeated(indent + 1)) .. stringify(item, indent + 1)
                if(i < obj size - 1, result = result .. ",")
                result = result .. "\n"
            )
            result = result .. ("  " repeated(indent)) .. "]"
            return result
        )
        
        if(obj type == "Map",
            if(obj size == 0, return "{}")
            
            result := "{\n"
            keys := obj keys sort
            keys foreach(i, key,
                result = result .. ("  " repeated(indent + 1)) .. "\"" .. key .. "\": " .. 
                         stringify(obj at(key), indent + 1)
                if(i < keys size - 1, result = result .. ",")
                result = result .. "\n"
            )
            result = result .. ("  " repeated(indent)) .. "}"
            return result
        )
        
        Exception raise("Unsupported type for JSON serialization: " .. obj type)
    )
)

// Example usage
if(isLaunchScript,
    parser := JsonParser clone
    
    testJson := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    
    parsed := parser parse(testJson)
    "Parsed object:" println
    parsed asJson println
    
    "\nSerialized back:" println
    serialized := parser stringify(parsed)
    serialized println
)