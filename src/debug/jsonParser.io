
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
            
            value := parseValue(tokens, i+2)
            obj atPut(key, value first)
            i = value second
        )
        obj
    )
    
    parseArray := method(str,
        arr := List clone
        if(str isEmpty, return arr)
        
        tokens := tokenize(str)
        i := 0
        while(i < tokens size,
            value := parseValue(tokens, i)
            arr append(value first)
            i = value second
            
            if(i < tokens size and tokens at(i) == ",") then(
                i = i + 1
            )
        )
        arr
    )
    
    parseValue := method(tokens, startIndex,
        token := tokens at(startIndex)
        
        if(token == "null", return list(nil, startIndex + 1))
        if(token == "true", return list(true, startIndex + 1))
        if(token == "false", return list(false, startIndex + 1))
        
        if(token at(0) == "\"", 
            return list(token slice(1, -1), startIndex + 1)
        )
        
        if(token contains(".") or token contains("e") or token contains("E"),
            return list(token asNumber, startIndex + 1)
        )
        
        if(token isNumeric,
            return list(token asNumber asInteger, startIndex + 1)
        )
        
        if(token == "{",
            // Find matching }
            depth := 1
            endIndex := startIndex + 1
            while(depth > 0 and endIndex < tokens size,
                if(tokens at(endIndex) == "{", depth = depth + 1)
                if(tokens at(endIndex) == "}", depth = depth - 1)
                endIndex = endIndex + 1
            )
            objStr := tokens slice(startIndex, endIndex) join(" ")
            return list(parseObject(objStr slice(1, -1)), endIndex)
        )
        
        if(token == "[",
            // Find matching ]
            depth := 1
            endIndex := startIndex + 1
            while(depth > 0 and endIndex < tokens size,
                if(tokens at(endIndex) == "[", depth = depth + 1)
                if(tokens at(endIndex) == "]", depth = depth - 1)
                endIndex = endIndex + 1
            )
            arrStr := tokens slice(startIndex, endIndex) join(" ")
            return list(parseArray(arrStr slice(1, -1)), endIndex)
        )
        
        Exception raise("Invalid value token: " .. token)
    )
    
    tokenize := method(str,
        tokens := List clone
        i := 0
        while(i < str size,
            c := str at(i)
            
            if(c isSpace, 
                i = i + 1
                continue
            )
            
            if(c == "{" or c == "}" or c == "[" or c == "]" or c == ":" or c == ",",
                tokens append(c asCharacter)
                i = i + 1
                continue
            )
            
            if(c == "\"",
                // Parse string
                j := i + 1
                while(j < str size and str at(j) != "\"",
                    if(str at(j) == "\\", j = j + 1) // Skip escaped character
                    j = j + 1
                )
                tokens append(str slice(i, j + 1))
                i = j + 1
                continue
            )
            
            // Parse number or literal
            j := i
            while(j < str size and not(str at(j) isSpace) and 
                  str at(j) != "," and str at(j) != "}" and 
                  str at(j) != "]" and str at(j) != ":",
                j = j + 1
            )
            
            token := str slice(i, j)
            tokens append(token)
            i = j
        )
        tokens
    )
    
    prettyPrint := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Boolean", return if(obj, "true", "false"))
        if(obj type == "Number", return obj asString)
        if(obj type == "Sequence", return "\"" .. obj .. "\"")
        
        if(obj type == "Map",
            if(obj isEmpty, return "{}")
            
            result := "{\n"
            obj keys foreach(i, key,
                result = result .. ("  " repeated(indent + 1)) .. "\"" .. key .. "\": "
                result = result .. prettyPrint(obj at(key), indent + 1)
                if(i < obj size - 1, result = result .. ",")
                result = result .. "\n"
            )
            result = result .. ("  " repeated(indent)) .. "}"
            return result
        )
        
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            
            result := "[\n"
            obj foreach(i, value,
                result = result .. ("  " repeated(indent + 1)) .. prettyPrint(value, indent + 1)
                if(i < obj size - 1, result = result .. ",")
                result = result .. "\n"
            )
            result = result .. ("  " repeated(indent)) .. "]"
            return result
        )
        
        Exception raise("Unsupported type for pretty printing: " .. obj type)
    )
)

// Example usage
if(isLaunchScript,
    jsonString := "{\"name\": \"John\", \"age\": 30, \"active\": true, \"scores\": [95, 87, 92]}"
    
    parser := JsonParser clone
    parsed := parser parse(jsonString)
    
    "Original JSON:" println
    jsonString println
    
    "\nParsed object:" println
    parsed asJson println
    
    "\nPretty printed:" println
    parser prettyPrint(parsed) println
    
    "\nAccessing values:" println
    ("Name: " .. (parsed at("name"))) println
    ("Age: " .. (parsed at("age"))) println
    ("Active: " .. (parsed at("active"))) println
    ("Scores: " .. (parsed at("scores"))) println
)