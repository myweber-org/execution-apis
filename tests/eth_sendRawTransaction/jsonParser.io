
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
        
        while(content size > 0,
            // Find key
            keyStart := content findSeq("\"")
            if(keyStart isNil, Exception raise("Invalid object: missing key"))
            
            keyEnd := content findSeq("\"", keyStart + 1)
            if(keyEnd isNil, Exception raise("Invalid object: unclosed key"))
            
            key := content exSlice(keyStart + 1, keyEnd)
            content := content exSlice(keyEnd + 1) strip
            
            // Find colon
            if(content beginsWithSeq(":") not,
                Exception raise("Invalid object: missing colon after key")
            )
            content := content exSlice(1) strip
            
            // Find value
            valueEnd := findValueEnd(content)
            valueStr := content exSlice(0, valueEnd)
            value := parse(valueStr)
            
            result atPut(key, value)
            
            // Move past value
            content := content exSlice(valueEnd) strip
            
            // Check for comma or end
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
        
        while(content size > 0,
            // Find value
            valueEnd := findValueEnd(content)
            valueStr := content exSlice(0, valueEnd)
            value := parse(valueStr)
            
            result append(value)
            
            // Move past value
            content := content exSlice(valueEnd) strip
            
            // Check for comma or end
            if(content beginsWithSeq(","),
                content := content exSlice(1) strip
            )
        )
        
        result
    )
    
    parseString := method(jsonString,
        // Remove quotes and unescape
        content := jsonString exSlice(1, -1)
        content replaceSeq("\\\"", "\"")
        content replaceSeq("\\\\", "\\")
        content replaceSeq("\\/", "/")
        content replaceSeq("\\b", "\b")
        content replaceSeq("\\f", "\f")
        content replaceSeq("\\n", "\n")
        content replaceSeq("\\r", "\r")
        content replaceSeq("\\t", "\t")
        content
    )
    
    findValueEnd := method(str,
        str := str strip
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
                if(stringEnd isNil, return str size)
                i = i + stringEnd - 1
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
        Exception raise("Unclosed string")
    )
    
    findSimpleValueEnd := method(str,
        i := 0
        while(i < str size,
            c := str at(i) asCharacter
            if(c == "," or c == "}" or c == "]",
                return i
            )
            i = i + 1
        )
        str size
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Sequence", return "\"" .. escapeString(obj) .. "\"")
        if(obj type == "Number", return obj asString)
        if(obj type == "Boolean", return if(obj, "true", "false"))
        
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            
            result := "[\n"
            spaces := " " repeated(indent + 2)
            
            obj foreach(i, value,
                result = result .. spaces .. stringify(value, indent + 2)
                if(i < obj size - 1, result = result .. ",")
                result = result .. "\n"
            )
            
            result = result .. " " repeated(indent) .. "]"
            return result
        )
        
        if(obj type == "Map",
            if(obj isEmpty, return "{}")
            
            result := "{\n"
            spaces := " " repeated(indent + 2)
            keys := obj keys sort
            
            keys foreach(i, key,
                result = result .. spaces .. "\"" .. key .. "\": " .. 
                        stringify(obj at(key), indent + 2)
                if(i < keys size - 1, result = result .. ",")
                result = result .. "\n"
            )
            
            result = result .. " " repeated(indent) .. "}"
            return result
        )
        
        Exception raise("Unsupported type for JSON serialization: " .. obj type)
    )
    
    escapeString := method(str,
        result := str clone
        result replaceSeq("\\", "\\\\")
        result replaceSeq("\"", "\\\"")
        result replaceSeq("\b", "\\b")
        result replaceSeq("\f", "\\f")
        result replaceSeq("\n", "\\n")
        result replaceSeq("\r", "\\r")
        result replaceSeq("\t", "\\t")
        result
    )
    
    prettyPrint := method(jsonString,
        parsed := parse(jsonString)
        stringify(parsed, 0) println
    )
)

// Example usage
if(isLaunchScript,
    testJson := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    
    "Parsing JSON:" println
    parsed := JsonParser parse(testJson)
    parsed keys foreach(key,
        ("  " .. key .. ": " .. parsed at(key)) println
    )
    
    "\nPretty printed:" println
    JsonParser prettyPrint(testJson)
)