
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty, 
            Exception raise("Empty JSON string")
        )
        
        // Remove whitespace
        trimmed := jsonString strip
        
        if(trimmed at(0) == "{" and trimmed at(-1) == "}", 
            parseObject(trimmed)
        ) elseif(trimmed at(0) == "[" and trimmed at(-1) == "]",
            parseArray(trimmed)
        ) else,
            Exception raise("Invalid JSON: must start with { or [")
        )
    )
    
    parseObject := method(str,
        result := Map clone
        content := str exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content isEmpty not,
            // Parse key
            keyStart := content findSeq("\"")
            if(keyStart isNil, Exception raise("Expected string key"))
            
            keyEnd := content findSeq("\"", keyStart + 1)
            if(keyEnd isNil, Exception raise("Unterminated string key"))
            
            key := content exSlice(keyStart + 1, keyEnd)
            
            // Find colon
            afterKey := content exSlice(keyEnd + 1) strip
            if(afterKey at(0) != ":", Exception raise("Expected colon after key"))
            
            // Parse value
            valueStr := afterKey exSlice(1) strip
            valueResult := parseValue(valueStr)
            value := valueResult at(0)
            consumed := valueResult at(1)
            
            result atPut(key, value)
            
            // Move to next pair or end
            remaining := valueStr exSlice(consumed) strip
            if(remaining isEmpty, break)
            
            if(remaining at(0) != ",", 
                Exception raise("Expected comma between object entries")
            )
            
            content = remaining exSlice(1) strip
        )
        
        result
    )
    
    parseArray := method(str,
        result := List clone
        content := str exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content isEmpty not,
            valueResult := parseValue(content)
            value := valueResult at(0)
            consumed := valueResult at(1)
            
            result append(value)
            
            remaining := content exSlice(consumed) strip
            if(remaining isEmpty, break)
            
            if(remaining at(0) != ",", 
                Exception raise("Expected comma between array elements")
            )
            
            content = remaining exSlice(1) strip
        )
        
        result
    )
    
    parseValue := method(str,
        if(str isEmpty, Exception raise("Unexpected end of JSON"))
        
        // String
        if(str at(0) == "\"",
            endQuote := str findSeq("\"", 1)
            if(endQuote isNil, Exception raise("Unterminated string"))
            
            value := str exSlice(1, endQuote)
            return list(value, endQuote + 1)
        )
        
        // Number
        if(str at(0) isDigit or str at(0) == "-",
            i := 0
            while(i < str size and (str at(i) isDigit or str at(i) == "." or str at(i) == "-" or str at(i) == "e" or str at(i) == "E"),
                i = i + 1
            )
            numStr := str exSlice(0, i)
            value := numStr asNumber
            return list(value, i)
        )
        
        // Boolean true
        if(str beginsWithSeq("true"),
            return list(true, 4)
        )
        
        // Boolean false
        if(str beginsWithSeq("false"),
            return list(false, 5)
        )
        
        // Null
        if(str beginsWithSeq("null"),
            return list(nil, 4)
        )
        
        // Object
        if(str at(0) == "{",
            depth := 1
            i := 1
            while(i < str size and depth > 0,
                if(str at(i) == "{", depth = depth + 1)
                if(str at(i) == "}", depth = depth - 1)
                i = i + 1
            )
            if(depth != 0, Exception raise("Unbalanced braces in object"))
            objStr := str exSlice(0, i)
            value := parseObject(objStr)
            return list(value, i)
        )
        
        // Array
        if(str at(0) == "[",
            depth := 1
            i := 1
            while(i < str size and depth > 0,
                if(str at(i) == "[", depth = depth + 1)
                if(str at(i) == "]", depth = depth - 1)
                i = i + 1
            )
            if(depth != 0, Exception raise("Unbalanced brackets in array"))
            arrStr := str exSlice(0, i)
            value := parseArray(arrStr)
            return list(value, i)
        )
        
        Exception raise("Invalid JSON value: " .. str)
    )
    
    prettyPrint := method(parsed, indent := 0,
        if(parsed isKindOf(Map),
            result := "{\n"
            count := 0
            parsed foreach(key, value,
                if(count > 0, result = result .. ",\n")
                result = result .. ("  " repeated(indent + 1)) .. "\"" .. key .. "\": "
                result = result .. prettyPrint(value, indent + 1)
                count = count + 1
            )
            result = result .. "\n" .. ("  " repeated(indent)) .. "}"
            result
        ) elseif(parsed isKindOf(List),
            result := "[\n"
            count := 0
            parsed foreach(value,
                if(count > 0, result = result .. ",\n")
                result = result .. ("  " repeated(indent + 1)) .. prettyPrint(value, indent + 1)
                count = count + 1
            )
            result = result .. "\n" .. ("  " repeated(indent)) .. "]"
            result
        ) elseif(parsed isKindOf(Sequence),
            "\"" .. parsed .. "\""
        ) elseif(parsed isNil,
            "null"
        ) else,
            parsed asString
        )
    )
)

// Example usage
if(isLaunchScript,
    jsonString := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"], \"active\": true}"
    
    parser := JsonParser clone
    parsed := parser parse(jsonString)
    
    "Original JSON:" println
    jsonString println
    
    "\nParsed structure:" println
    parsed asJson println
    
    "\nPretty printed:" println
    parser prettyPrint(parsed) println
)