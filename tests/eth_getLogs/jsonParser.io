
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            doString("(" .. jsonString .. ")")
        ) catch(Exception,
            Exception raise("Invalid JSON: " .. Exception error)
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
        cleanString := jsonString asMutable strip
        
        // Parse based on first character
        if(cleanString at(0) == "{",
            parseObject(cleanString)
        ) elseif(cleanString at(0) == "[",
            parseArray(cleanString)
        ) else,
            Exception raise("Invalid JSON: must start with { or [")
        )
    )
    
    parseObject := method(str,
        result := Map clone
        str = str exSlice(1, -1) // Remove surrounding {}
        
        while(str size > 0,
            // Parse key
            keyEnd := findStringEnd(str, 0)
            key := str exSlice(1, keyEnd - 1)
            
            // Find colon
            colonPos := str findSeq(":", keyEnd)
            if(colonPos == nil, Exception raise("Missing colon in object"))
            
            // Parse value
            valueStart := colonPos + 1
            valueEnd := findValueEnd(str, valueStart)
            valueStr := str exSlice(valueStart, valueEnd)
            
            // Parse the value
            value := parseValue(valueStr)
            result atPut(key, value)
            
            // Check for comma or end
            if(valueEnd < str size,
                if(str at(valueEnd) == ",",
                    str = str exSlice(valueEnd + 1)
                ,
                    str = str exSlice(valueEnd)
                )
            ,
                break
            )
        )
        
        result
    )
    
    parseArray := method(str,
        result := List clone
        str = str exSlice(1, -1) // Remove surrounding []
        
        while(str size > 0,
            // Parse value
            valueEnd := findValueEnd(str, 0)
            valueStr := str exSlice(0, valueEnd)
            
            value := parseValue(valueStr)
            result append(value)
            
            // Check for comma or end
            if(valueEnd < str size,
                if(str at(valueEnd) == ",",
                    str = str exSlice(valueEnd + 1)
                ,
                    str = str exSlice(valueEnd)
                )
            ,
                break
            )
        )
        
        result
    )
    
    parseValue := method(str,
        str = str strip
        
        if(str isEmpty, return nil)
        
        // Check type
        firstChar := str at(0)
        
        if(firstChar == "\"",
            // String
            end := findStringEnd(str, 0)
            return str exSlice(1, end - 1)
        ) elseif(firstChar == "{",
            // Object
            return parseObject(str)
        ) elseif(firstChar == "[",
            // Array
            return parseArray(str)
        ) elseif(str == "true",
            return true
        ) elseif(str == "false",
            return false
        ) elseif(str == "null",
            return nil
        ) else,
            // Number
            return str asNumber
        )
    )
    
    findStringEnd := method(str, start,
        i := start + 1
        while(i < str size,
            if(str at(i) == "\"",
                // Check if escaped
                if(str at(i-1) != "\\",
                    return i + 1
                )
            )
            i = i + 1
        )
        Exception raise("Unterminated string")
    )
    
    findValueEnd := method(str, start,
        i := start
        firstChar := str at(i)
        
        if(firstChar == "\"",
            return findStringEnd(str, i)
        ) elseif(firstChar == "{",
            depth := 1
            i = i + 1
            while(i < str size and depth > 0,
                ch := str at(i)
                if(ch == "{", depth = depth + 1)
                if(ch == "}", depth = depth - 1)
                i = i + 1
            )
            return i
        ) elseif(firstChar == "[",
            depth := 1
            i = i + 1
            while(i < str size and depth > 0,
                ch := str at(i)
                if(ch == "[", depth = depth + 1)
                if(ch == "]", depth = depth - 1)
                i = i + 1
            )
            return i
        ) else,
            // Simple value (number, boolean, null)
            while(i < str size,
                ch := str at(i)
                if(ch == "," or ch == "}" or ch == "]",
                    return i
                )
                i = i + 1
            )
            return i
        )
    )
    
    prettyPrint := method(parsed, indent := 0,
        if(parsed isKindOf(Map),
            "{\n" print
            count := 0
            parsed foreach(key, value,
                "  " repeated(indent + 1) print
                "\"#{key}\": " interpolate print
                prettyPrint(value, indent + 1)
                count = count + 1
                if(count < parsed size, ",\n" print, "\n" print)
            )
            "  " repeated(indent) print
            "}" print
        ) elseif(parsed isKindOf(List),
            "[\n" print
            count := 0
            parsed foreach(value,
                "  " repeated(indent + 1) print
                prettyPrint(value, indent + 1)
                count = count + 1
                if(count < parsed size, ",\n" print, "\n" print)
            )
            "  " repeated(indent) print
            "]" print
        ) elseif(parsed isKindOf(Sequence),
            "\"#{parsed}\"" interpolate print
        ) elseif(parsed isNil,
            "null" print
        ) else,
            parsed asString print
        )
    )
)

// Example usage
if(isLaunchScript,
    jsonString := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"], \"active\": true}"
    
    parser := JsonParser clone
    parsed := parser parse(jsonString)
    
    "Parsed JSON structure:\n" println
    parser prettyPrint(parsed)
    "\n\nAccessing values:\n" println
    writeln("Name: ", parsed at("name"))
    writeln("Age: ", parsed at("age"))
    writeln("Hobbies: ", parsed at("hobbies"))
    writeln("Active: ", parsed at("active"))
)