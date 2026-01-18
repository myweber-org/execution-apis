
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
            skipWhitespace := method(str, idx,
                while(idx < str size and str at(idx) isSpace,
                    idx = idx + 1
                )
                idx
            )
            
            idx = skipWhitespace(str, idx)
            
            if(str at(idx) == "}",
                return list(obj, idx + 1)
            )
            
            while(true,
                // Parse key
                result := parseString(str, idx)
                key := result at(0)
                idx = result at(1)
                
                idx = skipWhitespace(str, idx)
                
                if(str at(idx) != ":",
                    Exception raise("Expected : at position #{idx}" interpolate)
                )
                
                idx = idx + 1
                idx = skipWhitespace(str, idx)
                
                // Parse value
                result := parseValue(str, idx)
                value := result at(0)
                idx = result at(1)
                
                obj atPut(key, value)
                
                idx = skipWhitespace(str, idx)
                
                if(str at(idx) == "}",
                    return list(obj, idx + 1)
                )
                
                if(str at(idx) != ",",
                    Exception raise("Expected , or } at position #{idx}" interpolate)
                )
                
                idx = idx + 1
                idx = skipWhitespace(str, idx)
            )
        )
        
        parseArray := method(str, idx,
            arr := List clone
            skipWhitespace(str, idx)
            
            if(str at(idx) == "]",
                return list(arr, idx + 1)
            )
            
            while(true,
                result := parseValue(str, idx)
                value := result at(0)
                idx = result at(1)
                
                arr append(value)
                
                idx = skipWhitespace(str, idx)
                
                if(str at(idx) == "]",
                    return list(arr, idx + 1)
                )
                
                if(str at(idx) != ",",
                    Exception raise("Expected , or ] at position #{idx}" interpolate)
                )
                
                idx = idx + 1
                idx = skipWhitespace(str, idx)
            )
        )
        
        parseString := method(str, idx,
            start := idx
            while(idx < str size,
                ch := str at(idx)
                if(ch == "\"",
                    return list(str slice(start, idx), idx + 1)
                )
                
                if(ch == "\\",
                    idx = idx + 1  // Skip escaped character
                )
                
                idx = idx + 1
            )
            
            Exception raise("Unterminated string")
        )
        
        parseNumber := method(str, idx,
            start := idx
            while(idx < str size and (str at(idx) isDigit or str at(idx) in list(".", "-", "e", "E", "+")),
                idx = idx + 1
            )
            
            numStr := str slice(start, idx)
            // Simple number parsing - in production would use more robust method
            if(numStr contains("."),
                return list(numStr asNumber, idx)
            )
            
            return list(numStr asNumber, idx)
        )
        
        result := parseValue(cleanString, 0)
        result at(0)
    )
    
    prettyPrint := method(parsedObject, indentLevel := 0,
        indent := "  " repeated(indentLevel)
        
        if(parsedObject type == "Map",
            "{\n" print
            count := 0
            parsedObject keys foreach(key,
                if(count > 0, ",\n" print)
                "#{indent}  \"#{key}\": " interpolate print
                prettyPrint(parsedObject at(key), indentLevel + 1)
                count = count + 1
            )
            "\n#{indent}}" interpolate print
        )
        
        if(parsedObject type == "List",
            "[\n" print
            count := 0
            parsedObject foreach(value,
                if(count > 0, ",\n" print)
                "#{indent}  " interpolate print
                prettyPrint(value, indentLevel + 1)
                count = count + 1
            )
            "\n#{indent}]" interpolate print
        )
        
        if(parsedObject type == "Sequence",
            "\"#{parsedObject}\"" interpolate print
        )
        
        if(parsedObject type == "Number",
            parsedObject asString print
        )
        
        if(parsedObject isNil,
            "null" print
        )
        
        if(parsedObject type == "Boolean",
            parsedObject asString print
        )
    )
    
    validate := method(jsonString,
        try(
            parse(jsonString)
            true
        ) catch(Exception,
            false
        )
    )
)

// Example usage
if(isLaunchScript,
    jsonString := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    
    writeln("Valid JSON: ", JsonParser validate(jsonString))
    
    writeln("\nParsed object:")
    parsed := JsonParser parse(jsonString)
    parsed asJson println
    
    writeln("\nPretty printed:")
    JsonParser prettyPrint(parsed)
)