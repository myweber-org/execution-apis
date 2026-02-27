
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty, 
            Exception raise("Empty JSON string")
        )
        
        // Remove whitespace
        trimmed := jsonString strip
        
        if(trimmed at(0) == "{" and trimmed at(-1) == "}", 
            parseObject(trimmed slice(1, -1))
        ) elseif(trimmed at(0) == "[" and trimmed at(-1) == "]", 
            parseArray(trimmed slice(1, -1))
        ) else(
            Exception raise("Invalid JSON format")
        )
    )
    
    parseObject := method(str,
        obj := Map clone
        if(str isEmpty, return obj)
        
        tokens := tokenize(str)
        i := 0
        while(i < tokens size,
            key := tokens at(i)
            if(key at(0) != "\"", Exception raise("Invalid key: " .. key))
            key := key slice(1, -1)
            
            if(tokens at(i+1) != ":", Exception raise("Expected colon after key"))
            
            valueToken := tokens at(i+2)
            value := parseValue(valueToken)
            
            obj atPut(key, value)
            i = i + 3
            
            if(i < tokens size and tokens at(i) == ",",
                i = i + 1
            )
        )
        obj
    )
    
    parseArray := method(str,
        arr := List clone
        if(str isEmpty, return arr)
        
        tokens := tokenize(str)
        i := 0
        while(i < tokens size,
            value := parseValue(tokens at(i))
            arr append(value)
            i = i + 1
            
            if(i < tokens size and tokens at(i) == ",",
                i = i + 1
            )
        )
        arr
    )
    
    parseValue := method(token,
        if(token at(0) == "\"", 
            token slice(1, -1)
        ) elseif(token == "true",
            true
        ) elseif(token == "false",
            false
        ) elseif(token == "null",
            nil
        ) elseif(token contains("."),
            token asNumber
        ) elseif(token isNumeric,
            token asNumber
        ) elseif(token at(0) == "{",
            parseObject(token slice(1, -1))
        ) elseif(token at(0) == "[",
            parseArray(token slice(1, -1))
        ) else(
            Exception raise("Invalid value: " .. token)
        )
    )
    
    tokenize := method(str,
        tokens := List clone
        i := 0
        current := ""
        inString := false
        bracketDepth := 0
        braceDepth := 0
        
        while(i < str size,
            c := str at(i)
            
            if(c == "\"" and (i == 0 or str at(i-1) != "\\"),
                inString = inString not
                current = current .. c
            ) elseif(inString,
                current = current .. c
            ) elseif(c isSpace,
                if(current isEmpty not,
                    tokens append(current)
                    current = ""
                )
            ) elseif(c == "{" or c == "[",
                if(current isEmpty not,
                    tokens append(current)
                    current = ""
                )
                if(c == "{", braceDepth = braceDepth + 1)
                if(c == "[", bracketDepth = bracketDepth + 1)
                current = current .. c
            ) elseif(c == "}" or c == "]",
                if(current isEmpty not,
                    tokens append(current)
                    current = ""
                )
                if(c == "}", braceDepth = braceDepth - 1)
                if(c == "]", bracketDepth = bracketDepth - 1)
                current = current .. c
            ) elseif(c == ":" or c == ",",
                if(current isEmpty not,
                    tokens append(current)
                    current = ""
                )
                tokens append(c asCharacter)
            ) else(
                current = current .. c
            )
            
            i = i + 1
        )
        
        if(current isEmpty not,
            tokens append(current)
        )
        
        tokens
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj isKindOf(Sequence), return "\"" .. obj .. "\"")
        if(obj isKindOf(Number), return obj asString)
        if(obj isKindOf(True), return "true")
        if(obj isKindOf(False), return "false")
        
        if(obj isKindOf(Map),
            if(obj isEmpty, return "{}")
            
            result := "{\n"
            spaces := "  " repeated(indent + 1)
            
            first := true
            obj foreach(key, value,
                if(first not, result = result .. ",\n")
                first = false
                
                result = result .. spaces .. "\"" .. key .. "\": " .. stringify(value, indent + 1)
            )
            
            result = result .. "\n" .. "  " repeated(indent) .. "}"
            return result
        )
        
        if(obj isKindOf(List),
            if(obj isEmpty, return "[]")
            
            result := "[\n"
            spaces := "  " repeated(indent + 1)
            
            first := true
            obj foreach(value,
                if(first not, result = result .. ",\n")
                first = false
                
                result = result .. spaces .. stringify(value, indent + 1)
            )
            
            result = result .. "\n" .. "  " repeated(indent) .. "]"
            return result
        )
        
        Exception raise("Unsupported type for JSON serialization")
    )
)

// Example usage
if(isLaunchScript,
    jsonString := "{\"name\": \"John\", \"age\": 30, \"active\": true, \"tags\": [\"developer\", \"io\"]}"
    
    parser := JsonParser clone
    parsed := parser parse(jsonString)
    
    "Parsed object:" println
    parsed asJson println
    
    "\nPretty printed:" println
    pretty := parser stringify(parsed)
    pretty println
)