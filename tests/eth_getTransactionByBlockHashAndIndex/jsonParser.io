
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
            obj serialized(0, "  ")
        ,
            obj serialized
        )
    )
    
    prettyPrint := method(obj,
        stringify(obj, true) println
    )
)

// Example usage
parser := JsonParser clone
data := parser parse("{\"name\": \"John\", \"age\": 30, \"city\": \"New York\"}")
parser prettyPrint(data)
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty,
            Exception raise("Empty JSON string")
        )
        
        // Remove whitespace
        cleanString := jsonString asMutable strip
        
        // Parse based on first character
        if(cleanString beginsWithSeq("{"),
            parseObject(cleanString)
        elseif(cleanString beginsWithSeq("["),
            parseArray(cleanString)
        elseif(cleanString beginsWithSeq("\""),
            parseString(cleanString)
        elseif(cleanString asLowercase == "true",
            true
        elseif(cleanString asLowercase == "false",
            false
        elseif(cleanString asLowercase == "null",
            nil
        elseif(cleanString containsSeq("."),
            cleanString asNumber
        else,
            cleanString asNumber
        )
    )
    
    parseObject := method(str,
        result := Map clone
        content := str exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content size > 0,
            // Find key
            keyStart := content findSeq("\"")
            if(keyStart == -1, Exception raise("Invalid object key"))
            
            keyEnd := content findSeq("\"", keyStart + 1)
            if(keyEnd == -1, Exception raise("Unterminated string"))
            
            key := content exSlice(keyStart + 1, keyEnd)
            content = content exSlice(keyEnd + 1) strip
            
            // Find colon
            if(content beginsWithSeq(":") not,
                Exception raise("Expected colon after key")
            )
            content = content exSlice(1) strip
            
            // Find value
            valueEnd := findValueEnd(content)
            valueStr := content exSlice(0, valueEnd)
            value := parse(valueStr)
            
            result atPut(key, value)
            
            content = content exSlice(valueEnd) strip
            if(content beginsWithSeq(","),
                content = content exSlice(1) strip
            )
        )
        
        result
    )
    
    parseArray := method(str,
        result := List clone
        content := str exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content size > 0,
            valueEnd := findValueEnd(content)
            valueStr := content exSlice(0, valueEnd)
            value := parse(valueStr)
            
            result append(value)
            
            content = content exSlice(valueEnd) strip
            if(content beginsWithSeq(","),
                content = content exSlice(1) strip
            )
        )
        
        result
    )
    
    parseString := method(str,
        content := str exSlice(1, -1)
        content replaceSeq("\\\"", "\"") replaceSeq("\\\\", "\\")
    )
    
    findValueEnd := method(str,
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
                if(stringEnd == -1, Exception raise("Unterminated string"))
                i = i + stringEnd
            )
            i = i + 1
        )
        
        if(count != 0, Exception raise("Unmatched braces"))
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
        
        endPositions := list(commaPos, bracePos, bracketPos) select(isNil not)
        if(endPositions isEmpty, str size, endPositions min)
    )
    
    prettyPrint := method(obj, indent := 0,
        if(obj isKindOf(Map),
            "{\n" .. 
            obj keys map(k, 
                "  " repeated(indent + 1) .. 
                "\"" .. k .. "\": " .. 
                prettyPrint(obj at(k), indent + 1)
            ) join(",\n") ..
            "\n" .. "  " repeated(indent) .. "}"
        elseif(obj isKindOf(List),
            "[\n" ..
            obj map(v,
                "  " repeated(indent + 1) ..
                prettyPrint(v, indent + 1)
            ) join(",\n") ..
            "\n" .. "  " repeated(indent) .. "]"
        elseif(obj isKindOf(Sequence),
            "\"" .. obj .. "\""
        elseif(obj isNil,
            "null"
        else,
            obj asString
        )
    )
)

// Example usage
if(isLaunchScript,
    jsonString := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    
    parser := JsonParser clone
    parsed := parser parse(jsonString)
    
    "Parsed object:" println
    parsed asString println
    
    "\nPretty printed:" println
    parser prettyPrint(parsed) println
)