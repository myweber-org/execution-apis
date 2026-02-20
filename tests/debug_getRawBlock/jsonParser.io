
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty, 
            return Exception raise("Empty JSON string")
        )
        
        try(
            doString("(" .. jsonString .. ")")
        ) catch(e,
            Exception raise("Invalid JSON: " .. e error)
        )
    )
    
    stringify := method(obj, pretty := false,
        if(obj isNil, return "null")
        
        if(obj type == "Map",
            items := list()
            obj foreach(key, value,
                items append("\"" .. key .. "\": " .. stringify(value, pretty))
            )
            if(pretty,
                "{\n  " .. items join(",\n  ") .. "\n}"
            ,
                "{" .. items join(", ") .. "}"
            )
        ) else if(obj type == "List",
            items := obj map(v, stringify(v, pretty))
            if(pretty,
                "[\n  " .. items join(",\n  ") .. "\n]"
            ,
                "[" .. items join(", ") .. "]"
            )
        ) else if(obj type == "Sequence",
            "\"" .. obj asMutable escape .. "\""
        ) else if(obj type == "Number",
            obj asString
        ) else if(obj type == "Nil",
            "null"
        ) else if(obj type == "True" or obj type == "False",
            obj asString
        ) else (
            Exception raise("Unsupported type: " .. obj type)
        )
    )
    
    prettyPrint := method(obj,
        writeln(stringify(obj, true))
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
        content := jsonString exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content notEmpty,
            // Find key
            keyStart := content findSeq("\"")
            if(keyStart == -1, Exception raise("Invalid object key"))
            
            keyEnd := content findSeq("\"", keyStart + 1)
            if(keyEnd == -1, Exception raise("Unterminated object key"))
            
            key := content exSlice(keyStart + 1, keyEnd)
            content := content exSlice(keyEnd + 1) strip
            
            // Find colon
            if(content beginsWithSeq(":") not,
                Exception raise("Expected colon after key")
            )
            content := content exSlice(1) strip
            
            // Find value
            valueEnd := findValueEnd(content)
            valueStr := content exSlice(0, valueEnd)
            value := parse(valueStr)
            
            result atPut(key, value)
            
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
        content := jsonString exSlice(1, -1)
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
                stringEnd := findStringEnd(str exSlice(i))
                i = i + stringEnd
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
        Exception raise("Unterminated string")
    )
    
    findSimpleValueEnd := method(str,
        commaPos := str findSeq(",")
        bracePos := str findSeq("}")
        bracketPos := str findSeq("]")
        
        endPositions := List clone
        if(commaPos != -1, endPositions append(commaPos))
        if(bracePos != -1, endPositions append(bracePos))
        if(bracketPos != -1, endPositions append(bracketPos))
        
        if(endPositions isEmpty, return str size)
        endPositions min
    )
    
    prettyPrint := method(parsed, indent := 0,
        if(parsed type == "Map",
            "{\n" \
            .. parsed map(k, v,
                "  " repeated(indent + 1) \
                .. "\"" .. k .. "\": " \
                .. prettyPrint(v, indent + 1)
            ) join(",\n") \
            .. "\n" .. "  " repeated(indent) .. "}"
        elseif(parsed type == "List",
            "[\n" \
            .. parsed map(v,
                "  " repeated(indent + 1) \
                .. prettyPrint(v, indent + 1)
            ) join(",\n") \
            .. "\n" .. "  " repeated(indent) .. "]"
        elseif(parsed type == "Sequence",
            "\"" .. parsed .. "\""
        elseif(parsed == true,
            "true"
        elseif(parsed == false,
            "false"
        elseif(parsed == nil,
            "null"
        else,
            parsed asString
        )
    )
)

// Example usage
if(isLaunchScript,
    jsonString := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    
    parser := JsonParser clone
    parsed := parser parse(jsonString)
    
    "Parsed object:" println
    parsed keys foreach(k,
        (k .. ": " .. parsed at(k)) println
    )
    
    "\nPretty printed:" println
    parser prettyPrint(parsed) println
)