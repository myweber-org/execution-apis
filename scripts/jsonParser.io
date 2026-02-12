
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty, return nil)
        
        // Remove whitespace
        jsonString := jsonString strip
        
        // Parse based on first character
        firstChar := jsonString at(0)
        if(firstChar == "{", return parseObject(jsonString))
        if(firstChar == "[", return parseArray(jsonString))
        if(firstChar == "\"", return parseString(jsonString))
        if(jsonString asLowercase == "null", return nil)
        if(jsonString asLowercase == "true", return true)
        if(jsonString asLowercase == "false", return false)
        
        // Try parsing as number
        if(jsonString containsSeq(".") not,
            try(return jsonString asNumber)
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
            if(quoteIndex isNil, Exception raise("Expected '\"' in object"))
            
            endQuoteIndex := content findSeq("\"", quoteIndex + 1)
            if(endQuoteIndex isNil, Exception raise("Unterminated string in object"))
            
            key := content exSlice(quoteIndex + 1, endQuoteIndex)
            content := content exSlice(endQuoteIndex + 1) strip
            
            // Find colon
            colonIndex := content findSeq(":")
            if(colonIndex isNil, Exception raise("Expected ':' after key"))
            
            content := content exSlice(colonIndex + 1) strip
            
            // Parse value
            valueEnd := findValueEnd(content)
            valueStr := content exSlice(0, valueEnd)
            value := parse(valueStr)
            
            result atPut(key, value)
            
            // Move past value and optional comma
            content := content exSlice(valueEnd) strip
            if(content beginsWithSeq(","),
                content := content exSlice(1) strip
            )
        )
        
        result
    )
    
    parseArray := method(jsonString,
        result := List clone
        content := jsonString exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content notEmpty,
            valueEnd := findValueEnd(content)
            valueStr := content exSlice(0, valueEnd)
            value := parse(valueStr)
            
            result append(value)
            
            content := content exSlice(valueEnd) strip
            if(content beginsWithSeq(","),
                content := content exSlice(1) strip
            )
        )
        
        result
    )
    
    parseString := method(jsonString,
        // Remove quotes and handle escape sequences
        content := jsonString exSlice(1, -1)
        result := ""
        
        i := 0
        while(i < content size,
            c := content at(i)
            if(c == "\\",
                i = i + 1
                if(i >= content size, Exception raise("Invalid escape sequence"))
                
                nextChar := content at(i)
                if(nextChar == "\"", result = result .. "\"")
                if(nextChar == "\\", result = result .. "\\")
                if(nextChar == "/", result = result .. "/")
                if(nextChar == "b", result = result .. "\b")
                if(nextChar == "f", result = result .. "\f")
                if(nextChar == "n", result = result .. "\n")
                if(nextChar == "r", result = result .. "\r")
                if(nextChar == "t", result = result .. "\t")
                // Unicode escape not implemented
            ,
                result = result .. c
            )
            i = i + 1
        )
        
        result
    )
    
    findValueEnd := method(str,
        if(str isEmpty, return 0)
        
        firstChar := str at(0)
        if(firstChar == "\"",
            // Find closing quote
            i := 1
            while(i < str size,
                if(str at(i) == "\"",
                    // Check if it's escaped
                    if(str at(i-1) != "\\", return i + 1)
                )
                i = i + 1
            )
            Exception raise("Unterminated string")
        )
        
        if(firstChar == "{",
            depth := 1
            i := 1
            while(i < str size and depth > 0,
                c := str at(i)
                if(c == "{", depth = depth + 1)
                if(c == "}", depth = depth - 1)
                i = i + 1
            )
            return i
        )
        
        if(firstChar == "[",
            depth := 1
            i := 1
            while(i < str size and depth > 0,
                c := str at(i)
                if(c == "[", depth = depth + 1)
                if(c == "]", depth = depth - 1)
                i = i + 1
            )
            return i
        )
        
        // Find end of simple value
        i := 0
        while(i < str size,
            c := str at(i)
            if(c == "," or c == "}" or c == "]",
                return i
            )
            i = i + 1
        )
        
        str size
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Boolean", return if(obj, "true", "false"))
        if(obj type == "Number", return obj asString)
        if(obj type == "Sequence", return "\"" .. escapeString(obj) .. "\"")
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            
            result := "["
            obj foreach(i, item,
                if(i > 0, result = result .. ", ")
                result = result .. stringify(item, indent)
            )
            return result .. "]"
        )
        if(obj type == "Map",
            if(obj isEmpty, return "{}")
            
            result := "{"
            first := true
            obj keys foreach(key,
                if(first not, result = result .. ", ")
                first = false
                result = result .. "\"" .. key .. "\": " .. stringify(obj at(key), indent)
            )
            return result .. "}"
        )
        
        Exception raise("Cannot stringify type: " .. obj type)
    )
    
    escapeString := method(str,
        result := ""
        str foreach(c,
            if(c == "\"", result = result .. "\\\"")
            if(c == "\\", result = result .. "\\\\")
            if(c == "\b", result = result .. "\\b")
            if(c == "\f", result = result .. "\\f")
            if(c == "\n", result = result .. "\\n")
            if(c == "\r", result = result .. "\\r")
            if(c == "\t", result = result .. "\\t")
            // Add other characters as-is
            result = result .. c
        )
        result
    )
    
    prettyPrint := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Boolean", return if(obj, "true", "false"))
        if(obj type == "Number", return obj asString)
        if(obj type == "Sequence", return "\"" .. escapeString(obj) .. "\"")
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            
            result := "[\n"
            spaces := "  " repeated(indent + 1)
            obj foreach(i, item,
                if(i > 0, result = result .. ",\n")
                result = result .. spaces .. prettyPrint(item, indent + 1)
            )
            return result .. "\n" .. "  " repeated(indent) .. "]"
        )
        if(obj type == "Map",
            if(obj isEmpty, return "{}")
            
            result := "{\n"
            spaces := "  " repeated(indent + 1)
            first := true
            obj keys sort foreach(key,
                if(first not, result = result .. ",\n")
                first = false
                result = result .. spaces .. "\"" .. key .. "\": " .. prettyPrint(obj at(key), indent + 1)
            )
            return result .. "\n" .. "  " repeated(indent) .. "}"
        )
        
        Exception raise("Cannot pretty print type: " .. obj type)
    )
)