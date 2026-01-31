
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
        parsed := parse(jsonString)
        stringify(parsed, true)
    )
)
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty,
            Exception raise("Empty JSON string")
        )
        
        // Remove whitespace
        jsonString = jsonString strip
        
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
        if(jsonString asLowercase == "null",
            return nil
        )
        if(jsonString asLowercase == "true",
            return true
        )
        if(jsonString asLowercase == "false",
            return false
        )
        
        // Try parsing as number
        number := jsonString asNumber
        if(number isNan not,
            return number
        )
        
        Exception raise("Invalid JSON: " .. jsonString)
    )
    
    parseObject := method(jsonString,
        result := Map clone
        content := jsonString exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content isEmpty not,
            // Find key
            quoteIndex := content findSeq("\"")
            if(quoteIndex isNil,
                Exception raise("Expected string key in object")
            )
            
            endQuoteIndex := content findSeq("\"", quoteIndex + 1)
            if(endQuoteIndex isNil,
                Exception raise("Unterminated string in object key")
            )
            
            key := content exSlice(quoteIndex + 1, endQuoteIndex)
            
            // Find colon
            colonIndex := content findSeq(":", endQuoteIndex + 1)
            if(colonIndex isNil,
                Exception raise("Expected colon after key")
            )
            
            // Find value
            valueStart := colonIndex + 1
            valueEnd := findValueEnd(content, valueStart)
            
            valueStr := content exSlice(valueStart, valueEnd) strip
            value := parse(valueStr)
            
            result atPut(key, value)
            
            // Move to next pair or end
            content = content exSlice(valueEnd) strip
            if(content beginsWithSeq(","),
                content = content exSlice(1) strip
            )
        )
        
        result
    )
    
    parseArray := method(jsonString,
        result := List clone
        content := jsonString exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content isEmpty not,
            valueEnd := findValueEnd(content, 0)
            valueStr := content exSlice(0, valueEnd) strip
            value := parse(valueStr)
            
            result append(value)
            
            content = content exSlice(valueEnd) strip
            if(content beginsWithSeq(","),
                content = content exSlice(1) strip
            )
        )
        
        result
    )
    
    parseString := method(jsonString,
        content := jsonString exSlice(1, -1)
        // Simple string parsing - doesn't handle escapes
        content
    )
    
    findValueEnd := method(str, startIndex,
        str = str exSlice(startIndex) strip
        if(str beginsWithSeq("{"),
            return findMatchingBrace(str, "{", "}") + startIndex
        )
        if(str beginsWithSeq("["),
            return findMatchingBrace(str, "[", "]") + startIndex
        )
        if(str beginsWithSeq("\""),
            endQuote := str findSeq("\"", 1)
            if(endQuote isNil,
                Exception raise("Unterminated string")
            )
            return endQuote + 1 + startIndex
        )
        
        // Find next comma or end
        commaIndex := str findSeq(",")
        if(commaIndex isNil,
            return str size + startIndex
        )
        commaIndex + startIndex
    )
    
    findMatchingBrace := method(str, open, close,
        count := 1
        i := 1
        while(i < str size and count > 0,
            if(str at(i) asCharacter == open,
                count = count + 1
            )
            if(str at(i) asCharacter == close,
                count = count - 1
            )
            i = i + 1
        )
        if(count != 0,
            Exception raise("Unbalanced braces")
        )
        i
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Boolean", return obj asString)
        if(obj type == "Number", return obj asString)
        if(obj type == "Sequence", return "\"" .. obj .. "\"")
        
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            
            result := "[\n"
            obj foreach(i, item,
                result = result .. "  " repeated(indent + 1) .. stringify(item, indent + 1)
                if(i < obj size - 1, result = result .. ",")
                result = result .. "\n"
            )
            result = result .. "  " repeated(indent) .. "]"
            return result
        )
        
        if(obj type == "Map",
            if(obj isEmpty, return "{}")
            
            result := "{\n"
            keys := obj keys
            keys foreach(i, key,
                result = result .. "  " repeated(indent + 1) .. "\"" .. key .. "\": " .. 
                         stringify(obj at(key), indent + 1)
                if(i < keys size - 1, result = result .. ",")
                result = result .. "\n"
            )
            result = result .. "  " repeated(indent) .. "}"
            return result
        )
        
        Exception raise("Cannot stringify type: " .. obj type)
    )
)

// Example usage
if(isLaunchScript,
    jsonString := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    
    parser := JsonParser clone
    parsed := parser parse(jsonString)
    
    "Parsed object:" println
    parsed asJson println
    
    "\nPretty printed:" println
    pretty := parser stringify(parsed)
    pretty println
)