
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
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            doString("(" .. jsonString .. ")")
        ) catch(e,
            Exception raise("Invalid JSON: " .. e error)
        )
    )

    stringify := method(obj, pretty := false,
        if(pretty,
            _stringifyPretty(obj, "")
        ,
            _stringify(obj)
        )
    )

    _stringify := method(obj,
        if(obj isNil, return "null")
        if(obj isKindOf(Number), return obj asString)
        if(obj isKindOf(Sequence), return "\"" .. obj asString escape .. "\"")
        if(obj isKindOf(List),
            items := list()
            obj foreach(i, v, items append(_stringify(v)))
            return "[" .. items join(",") .. "]"
        )
        if(obj isKindOf(Map),
            pairs := list()
            obj foreach(k, v,
                pairs append("\"" .. k asString escape .. "\":" .. _stringify(v))
            )
            return "{" .. pairs join(",") .. "}"
        )
        Exception raise("Unsupported type for JSON serialization")
    )

    _stringifyPretty := method(obj, indent,
        newIndent := indent .. "  "
        if(obj isNil, return "null")
        if(obj isKindOf(Number), return obj asString)
        if(obj isKindOf(Sequence), return "\"" .. obj asString escape .. "\"")
        if(obj isKindOf(List),
            if(obj isEmpty, return "[]")
            items := list()
            obj foreach(i, v,
                items append(newIndent .. _stringifyPretty(v, newIndent))
            )
            return "[\n" .. items join(",\n") .. "\n" .. indent .. "]"
        )
        if(obj isKindOf(Map),
            if(obj isEmpty, return "{}")
            pairs := list()
            obj foreach(k, v,
                pairs append(newIndent .. "\"" .. k asString escape .. "\": " .. _stringifyPretty(v, newIndent))
            )
            return "{\n" .. pairs join(",\n") .. "\n" .. indent .. "}"
        )
        Exception raise("Unsupported type for JSON serialization")
    )
)
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty, 
            Exception raise("Empty JSON string")
        )
        
        // Remove whitespace
        trimmed := jsonString strip
        
        // Handle different JSON types
        if(trimmed beginsWithSeq("\""), 
            return self parseString(trimmed)
        )
        if(trimmed beginsWithSeq("{"),
            return self parseObject(trimmed)
        )
        if(trimmed beginsWithSeq("["),
            return self parseArray(trimmed)
        )
        if(trimmed asLowercase == "null",
            return nil
        )
        if(trimmed asLowercase == "true",
            return true
        )
        if(trimmed asLowercase == "false",
            return false
        )
        
        // Try parsing as number
        self parseNumber(trimmed)
    )
    
    parseString := method(str,
        // Remove quotes and unescape characters
        content := str exSlice(1, -1)
        content replaceSeq("\\\"", "\"") replaceSeq("\\\\", "\\")
    )
    
    parseObject := method(str,
        obj := Map clone
        content := str exSlice(1, -1) strip
        
        if(content isEmpty, return obj)
        
        pairs := content split(",")
        pairs foreach(pair,
            pair := pair strip
            colonIndex := pair findSeq(":")
            if(colonIndex isNil,
                Exception raise("Invalid object pair: " .. pair)
            )
            
            key := pair exSlice(0, colonIndex) strip
            value := pair exSlice(colonIndex + 1) strip
            
            if(not key beginsWithSeq("\""),
                Exception raise("Object key must be string: " .. key)
            )
            
            parsedKey := self parseString(key)
            parsedValue := self parse(value)
            
            obj atPut(parsedKey, parsedValue)
        )
        
        obj
    )
    
    parseArray := method(str,
        arr := List clone
        content := str exSlice(1, -1) strip
        
        if(content isEmpty, return arr)
        
        elements := content split(",")
        elements foreach(element,
            arr append(self parse(element strip))
        )
        
        arr
    )
    
    parseNumber := method(str,
        // Try integer first
        intValue := str asNumber
        if(intValue isNan not, return intValue)
        
        // Try float
        floatValue := str asFloat
        if(floatValue isNan not, return floatValue)
        
        Exception raise("Invalid number: " .. str)
    )
    
    prettyPrint := method(parsed, indentLevel := 0,
        indent := "  " repeated(indentLevel)
        
        if(parsed isNil, return "null")
        if(parsed type == "Boolean", return parsed asString)
        if(parsed type == "Number", return parsed asString)
        if(parsed type == "Sequence", return "\"" .. parsed .. "\"")
        
        if(parsed type == "List",
            if(parsed isEmpty, return "[]")
            
            result := "[\n"
            parsed foreach(i, value,
                result = result .. indent .. "  " .. self prettyPrint(value, indentLevel + 1)
                if(i < parsed size - 1, result = result .. ",")
                result = result .. "\n"
            )
            result = result .. indent .. "]"
            return result
        )
        
        if(parsed type == "Map",
            if(parsed isEmpty, return "{}")
            
            result := "{\n"
            keys := parsed keys
            keys foreach(i, key,
                result = result .. indent .. "  \"" .. key .. "\": " .. 
                        self prettyPrint(parsed at(key), indentLevel + 1)
                if(i < keys size - 1, result = result .. ",")
                result = result .. "\n"
            )
            result = result .. indent .. "}"
            return result
        )
        
        parsed asString
    )
)

// Example usage
if(isLaunchScript,
    jsonString := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    
    parser := JsonParser clone
    parsed := parser parse(jsonString)
    
    "Original JSON:" println
    jsonString println
    
    "\nParsed structure:" println
    parsed asString println
    
    "\nPretty printed:" println
    parser prettyPrint(parsed) println
)