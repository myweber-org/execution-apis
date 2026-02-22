
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
        if(firstChar isDigit or firstChar == "-", return parseNumber(jsonString))
        if(jsonString beginsWithSeq("true"), return true)
        if(jsonString beginsWithSeq("false"), return false)
        if(jsonString beginsWithSeq("null"), return nil)
        
        Exception raise("Invalid JSON: " .. jsonString)
    )
    
    parseObject := method(jsonString,
        result := Map clone
        content := jsonString exSlice(1, -1) strip
        
        while(content size > 0,
            // Find key
            quoteIndex := content findSeq("\"")
            if(quoteIndex isNil, Exception raise("Expected '\"' in object"))
            
            endQuoteIndex := content findSeq("\"", quoteIndex + 1)
            if(endQuoteIndex isNil, Exception raise("Unterminated string in object"))
            
            key := content exSlice(quoteIndex + 1, endQuoteIndex)
            remaining := content exSlice(endQuoteIndex + 1) strip
            
            // Expect colon
            if(remaining at(0) != ":", Exception raise("Expected ':' after key"))
            remaining := remaining exSlice(1) strip
            
            // Parse value
            valueResult := parseValue(remaining)
            value := valueResult at(0)
            valueEnd := valueResult at(1)
            
            result atPut(key, value)
            
            // Check for next item or end
            remaining := remaining exSlice(valueEnd) strip
            if(remaining size == 0, break)
            
            if(remaining at(0) != ",", Exception raise("Expected ',' or end of object"))
            content := remaining exSlice(1) strip
        )
        
        result
    )
    
    parseArray := method(jsonString,
        result := List clone
        content := jsonString exSlice(1, -1) strip
        
        while(content size > 0,
            // Parse value
            valueResult := parseValue(content)
            value := valueResult at(0)
            valueEnd := valueResult at(1)
            
            result append(value)
            
            // Check for next item or end
            remaining := content exSlice(valueEnd) strip
            if(remaining size == 0, break)
            
            if(remaining at(0) != ",", Exception raise("Expected ',' or end of array"))
            content := remaining exSlice(1) strip
        )
        
        result
    )
    
    parseValue := method(jsonString,
        if(jsonString size == 0, return list(nil, 0))
        
        firstChar := jsonString at(0)
        if(firstChar == "{",
            objEnd := findMatchingBrace(jsonString, "{", "}")
            return list(parseObject(jsonString exSlice(0, objEnd + 1)), objEnd + 1)
        )
        
        if(firstChar == "[",
            arrEnd := findMatchingBrace(jsonString, "[", "]")
            return list(parseArray(jsonString exSlice(0, arrEnd + 1)), arrEnd + 1)
        )
        
        if(firstChar == "\"",
            strEnd := findStringEnd(jsonString)
            return list(parseString(jsonString exSlice(0, strEnd + 1)), strEnd + 1)
        )
        
        // Parse literal values
        if(jsonString beginsWithSeq("true"), return list(true, 4))
        if(jsonString beginsWithSeq("false"), return list(false, 5))
        if(jsonString beginsWithSeq("null"), return list(nil, 4))
        
        // Parse number
        numEnd := findNumberEnd(jsonString)
        return list(parseNumber(jsonString exSlice(0, numEnd)), numEnd)
    )
    
    findMatchingBrace := method(str, open, close,
        count := 0
        for(i, 0, str size - 1,
            ch := str at(i)
            if(ch == open, count = count + 1)
            if(ch == close,
                count = count - 1
                if(count == 0, return i)
            )
        )
        Exception raise("Unmatched " .. open .. " in JSON")
    )
    
    findStringEnd := method(str,
        i := 1
        while(i < str size,
            ch := str at(i)
            if(ch == "\"",
                // Check if it's escaped
                if(str at(i - 1) != "\\", return i)
            )
            i = i + 1
        )
        Exception raise("Unterminated string in JSON")
    )
    
    findNumberEnd := method(str,
        i := 0
        while(i < str size,
            ch := str at(i)
            if(ch isDigit or ch == "-" or ch == "+" or ch == "." or ch == "e" or ch == "E",
                i = i + 1
            ,
                break
            )
        )
        i
    )
    
    parseString := method(jsonString,
        jsonString exSlice(1, -1) replaceSeq("\\\"", "\"")
    )
    
    parseNumber := method(jsonString,
        jsonString asNumber
    )
    
    prettyPrint := method(parsed, indent := 0,
        if(parsed isNil, return "null")
        if(parsed type == "Boolean", return if(parsed, "true", "false"))
        if(parsed type == "Number", return parsed asString)
        if(parsed type == "Sequence", return "\"" .. parsed .. "\"")
        
        if(parsed type == "Map",
            if(parsed size == 0, return "{}")
            
            result := "{\n"
            spaces := "  " repeated(indent + 1)
            
            parsed keys foreach(i, key,
                result = result .. spaces .. "\"" .. key .. "\": "
                result = result .. prettyPrint(parsed at(key), indent + 1)
                if(i < parsed size - 1, result = result .. ",")
                result = result .. "\n"
            )
            
            result = result .. ("  " repeated(indent)) .. "}"
            return result
        )
        
        if(parsed type == "List",
            if(parsed size == 0, return "[]")
            
            result := "[\n"
            spaces := "  " repeated(indent + 1)
            
            parsed foreach(i, value,
                result = result .. spaces .. prettyPrint(value, indent + 1)
                if(i < parsed size - 1, result = result .. ",")
                result = result .. "\n"
            )
            
            result = result .. ("  " repeated(indent)) .. "]"
            return result
        )
        
        Exception raise("Unsupported type for pretty printing: " .. parsed type)
    )
)

// Example usage
if(isLaunchScript,
    json := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    parsed := JsonParser parse(json)
    "Parsed: " println
    parsed asJson println
    
    "\nPretty printed:" println
    JsonParser prettyPrint(parsed) println
)