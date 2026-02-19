
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty,
            Exception raise("Empty JSON string")
        )
        
        // Remove whitespace
        cleanString := jsonString strip
        
        // Parse based on first character
        if(cleanString at(0) == "{",
            return parseObject(cleanString)
        )
        if(cleanString at(0) == "[",
            return parseArray(cleanString)
        )
        
        Exception raise("Invalid JSON: must start with { or [")
    )
    
    parseObject := method(str,
        result := Map clone
        content := str exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content size > 0,
            // Parse key
            keyStart := content findSeq("\"")
            if(keyStart == -1, Exception raise("Missing key in object"))
            
            keyEnd := content findSeq("\"", keyStart + 1)
            if(keyEnd == -1, Exception raise("Unterminated key"))
            
            key := content exSlice(keyStart + 1, keyEnd)
            content = content exSlice(keyEnd + 1) strip
            
            // Check for colon
            if(content at(0) != ':',
                Exception raise("Expected colon after key")
            )
            content = content exSlice(1) strip
            
            // Parse value
            valueResult := parseValue(content)
            result atPut(key, valueResult first)
            content = valueResult second
            
            // Check for comma or end
            if(content size > 0,
                if(content at(0) == ',',
                    content = content exSlice(1) strip
                )
            )
        )
        
        result
    )
    
    parseArray := method(str,
        result := List clone
        content := str exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content size > 0,
            valueResult := parseValue(content)
            result append(valueResult first)
            content = valueResult second
            
            if(content size > 0,
                if(content at(0) == ',',
                    content = content exSlice(1) strip
                )
            )
        )
        
        result
    )
    
    parseValue := method(str,
        if(str isEmpty, Exception raise("Unexpected end of JSON"))
        
        firstChar := str at(0)
        
        if(firstChar == "\"",
            return parseString(str)
        )
        
        if(firstChar == "{",
            objResult := parseObject(str)
            remaining := str exSlice(findMatchingBrace(str, 0) + 1) strip
            return list(objResult, remaining)
        )
        
        if(firstChar == "[",
            arrResult := parseArray(str)
            remaining := str exSlice(findMatchingBrace(str, 0) + 1) strip
            return list(arrResult, remaining)
        )
        
        if(str beginsWithSeq("true"),
            return list(true, str exSlice(4) strip)
        )
        
        if(str beginsWithSeq("false"),
            return list(false, str exSlice(5) strip)
        )
        
        if(str beginsWithSeq("null"),
            return list(nil, str exSlice(4) strip)
        )
        
        // Parse number
        return parseNumber(str)
    )
    
    parseString := method(str,
        endQuote := str findSeq("\"", 1)
        if(endQuote == -1, Exception raise("Unterminated string"))
        
        value := str exSlice(1, endQuote)
        remaining := str exSlice(endQuote + 1) strip
        
        list(value, remaining)
    )
    
    parseNumber := method(str,
        i := 0
        while(i < str size,
            c := str at(i)
            if(c isDigit or c == '.' or c == '-' or c == 'e' or c == 'E' or c == '+',
                i = i + 1
            ,
                break
            )
        )
        
        numberStr := str exSlice(0, i)
        value := numberStr asNumber
        remaining := str exSlice(i) strip
        
        list(value, remaining)
    )
    
    findMatchingBrace := method(str, start,
        braceStack := 0
        quoteOpen := false
        i := start
        
        while(i < str size,
            c := str at(i)
            
            if(c == "\"" and (i == 0 or str at(i-1) != "\\"),
                quoteOpen = quoteOpen not
            )
            
            if(not quoteOpen,
                if(c == str at(start),
                    braceStack = braceStack + 1
                )
                if(c == matchingBrace(str at(start)),
                    braceStack = braceStack - 1
                    if(braceStack == 0,
                        return i
                    )
                )
            )
            
            i = i + 1
        )
        
        Exception raise("Unmatched brace")
    )
    
    matchingBrace := method(brace,
        if(brace == "{", return "}")
        if(brace == "[", return "]")
        Exception raise("Not a brace")
    )
    
    prettyPrint := method(obj, indent := 0,
        if(obj isKindOf(Map),
            if(obj isEmpty, return "{}")
            
            result := "{\n"
            obj foreach(key, value,
                result = result .. ("  " repeated(indent + 1)) .. "\"" .. key .. "\": " .. 
                         prettyPrint(value, indent + 1) .. ",\n"
            )
            result = result exSlice(0, -2) .. "\n" .. ("  " repeated(indent)) .. "}"
            return result
        )
        
        if(obj isKindOf(List),
            if(obj isEmpty, return "[]")
            
            result := "[\n"
            obj foreach(value,
                result = result .. ("  " repeated(indent + 1)) .. 
                         prettyPrint(value, indent + 1) .. ",\n"
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
        
        obj asString
    )
)

// Example usage
/*
jsonString := "{\"name\":\"John\",\"age\":30,\"hobbies\":[\"reading\",\"coding\"]}"
parsed := JsonParser parse(jsonString)
JsonParser prettyPrint(parsed) println
*/