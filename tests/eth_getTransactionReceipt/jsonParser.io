
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            doString("(" .. jsonString .. ")")
        ) catch(
            Exception raise("Invalid JSON format")
        )
    )
    
    stringify := method(obj, pretty := false,
        if(pretty,
            obj serialized,
            obj asJson
        )
    )
    
    validate := method(jsonString,
        try(
            parse(jsonString)
            true
        ) catch(
            false
        )
    )
    
    prettyPrint := method(jsonString,
        obj := parse(jsonString)
        stringify(obj, true)
    )
)
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty, return nil)
        
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
        return parseNumber(jsonString)
    )
    
    parseObject := method(jsonString,
        result := Map clone
        content := jsonString exSlice(1, -1) strip
        
        while(content size > 0,
            // Find key
            keyStart := content findSeq("\"")
            if(keyStart == -1, break)
            
            keyEnd := content findSeq("\"", keyStart + 1)
            if(keyEnd == -1, break)
            
            key := content exSlice(keyStart + 1, keyEnd)
            
            // Find colon
            colonPos := content findSeq(":", keyEnd + 1)
            if(colonPos == -1, break)
            
            // Find value
            valueStart := colonPos + 1
            valueStr := content exSlice(valueStart) strip
            
            // Parse value
            value := parseValue(valueStr)
            
            // Store in result
            result atPut(key, value)
            
            // Calculate how much we consumed
            valueEnd := valueStart + valueStr size
            if(value isKindOf(Sequence), valueEnd = valueEnd + 2) // Add quotes
            
            // Move to next pair
            nextComma := content findSeq(",", valueEnd)
            if(nextComma == -1, break)
            
            content = content exSlice(nextComma + 1) strip
        )
        
        result
    )
    
    parseArray := method(jsonString,
        result := List clone
        content := jsonString exSlice(1, -1) strip
        
        while(content size > 0,
            // Parse next value
            value := parseValue(content)
            result append(value)
            
            // Calculate consumed length
            consumed := content size - (content exSlice(consumed) strip size)
            
            // Find next comma
            nextComma := content findSeq(",", consumed)
            if(nextComma == -1, break)
            
            content = content exSlice(nextComma + 1) strip
        )
        
        result
    )
    
    parseString := method(jsonString,
        jsonString exSlice(1, -1)
    )
    
    parseNumber := method(jsonString,
        // Try integer first
        number := jsonString asNumber
        if(number isNan, return jsonString) // Return as string if not a number
        number
    )
    
    parseValue := method(str,
        if(str beginsWithSeq("{"),
            return parseObject(str)
        )
        if(str beginsWithSeq("["),
            return parseArray(str)
        )
        if(str beginsWithSeq("\""),
            return parseString(str)
        )
        if(str asLowercase == "null",
            return nil
        )
        if(str asLowercase == "true",
            return true
        )
        if(str asLowercase == "false",
            return false
        )
        
        parseNumber(str)
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj == true, return "true")
        if(obj == false, return "false")
        
        if(obj isKindOf(Number),
            return obj asString
        )
        
        if(obj isKindOf(Sequence),
            return "\"" .. obj .. "\""
        )
        
        if(obj isKindOf(Map),
            result := "{\n"
            spaces := "  " repeated(indent + 1)
            
            obj keys foreach(i, key,
                if(i > 0, result = result .. ",\n")
                result = result .. spaces .. "\"" .. key .. "\": "
                result = result .. stringify(obj at(key), indent + 1)
            )
            
            result = result .. "\n" .. ("  " repeated(indent)) .. "}"
            return result
        )
        
        if(obj isKindOf(List),
            result := "[\n"
            spaces := "  " repeated(indent + 1)
            
            obj foreach(i, item,
                if(i > 0, result = result .. ",\n")
                result = result .. spaces .. stringify(item, indent + 1)
            )
            
            result = result .. "\n" .. ("  " repeated(indent)) .. "]"
            return result
        )
        
        "\"" .. obj asString .. "\""
    )
    
    prettyPrint := method(obj,
        writeln(stringify(obj))
    )
)

// Example usage
if(isLaunchScript,
    parser := JsonParser clone
    
    jsonStr := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    
    writeln("Parsing JSON:")
    parsed := parser parse(jsonStr)
    
    writeln("\nParsed object:")
    parsed keys foreach(key,
        writeln(key, ": ", parsed at(key))
    )
    
    writeln("\nPretty printed:")
    parser prettyPrint(parsed)
)