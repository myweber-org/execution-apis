
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty,
            Exception raise("Empty JSON string")
        )
        
        // Remove whitespace
        jsonString := jsonString strip
        
        // Parse based on first character
        if(jsonString beginsWithSeq("{"),
            return parseObject(jsonString)
        )
        if(jsonString beginsWithSeq("["),
            return parseArray(jsonString)
        )
        if(jsonString beginsWithSeq("\""),
            return parseString(jsonString)
        )
        
        // Parse literals
        if(jsonString == "true", return true)
        if(jsonString == "false", return false)
        if(jsonString == "null", return nil)
        
        // Parse number
        if(jsonString asNumber != nil,
            return jsonString asNumber
        )
        
        Exception raise("Invalid JSON: " .. jsonString)
    )
    
    parseObject := method(jsonString,
        result := Map clone
        content := jsonString exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content notEmpty,
            // Find key
            quoteIndex := content findSeq("\"")
            if(quoteIndex == nil,
                Exception raise("Expected string key in object")
            )
            
            endQuoteIndex := content findSeq("\"", quoteIndex + 1)
            if(endQuoteIndex == nil,
                Exception raise("Unterminated string key")
            )
            
            key := content exSlice(quoteIndex + 1, endQuoteIndex)
            
            // Find colon
            colonIndex := content findSeq(":", endQuoteIndex + 1)
            if(colonIndex == nil,
                Exception raise("Expected colon after key")
            )
            
            // Find value
            valueStart := colonIndex + 1
            valueEnd := findValueEnd(content, valueStart)
            
            valueStr := content exSlice(valueStart, valueEnd) strip
            value := parse(valueStr)
            
            result atPut(key, value)
            
            // Check for comma or end
            if(valueEnd < content size,
                nextChar := content at(valueEnd)
                if(nextChar == ',',
                    content = content exSlice(valueEnd + 1) strip
                ) else if(nextChar == '}',
                    break
                ) else (
                    Exception raise("Expected comma or closing brace")
                )
            ) else (
                break
            )
        )
        
        return result
    )
    
    parseArray := method(jsonString,
        result := List clone
        content := jsonString exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content notEmpty,
            valueEnd := findValueEnd(content, 0)
            valueStr := content exSlice(0, valueEnd) strip
            value := parse(valueStr)
            
            result append(value)
            
            if(valueEnd < content size,
                nextChar := content at(valueEnd)
                if(nextChar == ',',
                    content = content exSlice(valueEnd + 1) strip
                ) else if(nextChar == ']',
                    break
                ) else (
                    Exception raise("Expected comma or closing bracket")
                )
            ) else (
                break
            )
        )
        
        return result
    )
    
    parseString := method(jsonString,
        content := jsonString exSlice(1, -1)
        // Simple unescaping - would need full implementation for production
        content replaceSeq("\\\"", "\"") replaceSeq("\\\\", "\\")
    )
    
    findValueEnd := method(str, startIndex,
        i := startIndex
        while(i < str size,
            c := str at(i)
            
            if(c == ' ' or c == '\t' or c == '\n' or c == '\r',
                i = i + 1
                continue
            )
            
            if(c == '"',
                endQuote := str findSeq("\"", i + 1)
                if(endQuote == nil,
                    Exception raise("Unterminated string")
                )
                return endQuote + 1
            )
            
            if(c == '{' or c == '[',
                depth := 1
                j := i + 1
                while(j < str size,
                    ch := str at(j)
                    if(ch == '{' or ch == '[',
                        depth = depth + 1
                    )
                    if(ch == '}' or ch == ']',
                        depth = depth - 1
                        if(depth == 0,
                            return j + 1
                        )
                    )
                    j = j + 1
                )
                Exception raise("Unterminated object or array")
            )
            
            // For literals and numbers
            j := i
            while(j < str size,
                ch := str at(j)
                if(ch == ',' or ch == '}' or ch == ']' or ch == ' ',
                    return j
                )
                j = j + 1
            )
            return str size
        )
        
        return str size
    )
    
    prettyPrint := method(obj, indent := 0,
        if(obj isKindOf(Map),
            if(obj isEmpty, return "{}")
            
            result := "{\n"
            obj foreach(key, value,
                result = result .. ("  " repeated(indent + 1)) .. "\"" .. key .. "\": " .. prettyPrint(value, indent + 1) .. ",\n"
            )
            result = result exSlice(0, -2) .. "\n" .. ("  " repeated(indent)) .. "}"
            return result
        )
        
        if(obj isKindOf(List),
            if(obj isEmpty, return "[]")
            
            result := "[\n"
            obj foreach(value,
                result = result .. ("  " repeated(indent + 1)) .. prettyPrint(value, indent + 1) .. ",\n"
            )
            result = result exSlice(0, -2) .. "\n" .. ("  " repeated(indent)) .. "]"
            return result
        )
        
        if(obj isKindOf(Sequence),
            return "\"" .. obj .. "\""
        )
        
        if(obj isNil,
            return "null"
        )
        
        return obj asString
    )
)

// Example usage
if(isLaunchScript,
    jsonString := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    
    parser := JsonParser clone
    parsed := parser parse(jsonString)
    
    "Parsed object:" println
    parsed prettyPrint println
    
    "Accessing values:" println
    ("Name: " .. (parsed at("name"))) println
    ("Age: " .. (parsed at("age"))) println
    ("First hobby: " .. (parsed at("hobbies") at(0))) println
)