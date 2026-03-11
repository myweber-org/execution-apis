
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
            
            // Expect colon
            if(content beginsWithSeq(":") not,
                Exception raise("Expected colon after key")
            )
            
            content = content exSlice(1) strip
            
            // Parse value
            valueEnd := findValueEnd(content)
            valueStr := content exSlice(0, valueEnd)
            value := parse(valueStr)
            
            result atPut(key, value)
            
            // Move past value
            content = content exSlice(valueEnd) strip
            
            // Check for comma or end
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
        str exSlice(1, -1)
    )
    
    findValueEnd := method(str,
        if(str beginsWithSeq("\""),
            end := str findSeq("\"", 1)
            while(end != -1 and str at(end - 1) == $\\,
                end = str findSeq("\"", end + 1)
            )
            if(end == -1, Exception raise("Unterminated string"))
            end + 1
        elseif(str beginsWithSeq("{") or str beginsWithSeq("["),
            depth := 0
            i := 0
            while(i < str size,
                c := str at(i)
                if(c == ${, depth = depth + 1)
                elseif(c == $}, depth = depth - 1)
                elseif(c == $[, depth = depth + 1)
                elseif(c == $], depth = depth - 1)
                
                if(depth == 0, return i + 1)
                i = i + 1
            )
            Exception raise("Unterminated object or array")
        else,
            // Simple value (number, boolean, null)
            commaPos := str findSeq(",")
            endPos := str size
            if(commaPos != -1 and commaPos < endPos,
                endPos = commaPos
            )
            endPos
        )
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Sequence", return "\"" .. obj .. "\"")
        if(obj type == "Number", return obj asString)
        if(obj type == "Boolean", return obj asString)
        
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            
            result := "[\n"
            spaces := " " repeated(indent + 2)
            
            obj foreach(i, item,
                result = result .. spaces .. stringify(item, indent + 2)
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
        
        Exception raise("Unsupported type for JSON serialization")
    )
)

// Example usage
if(isLaunchScript,
    testJson := "{\"name\": \"John\", \"age\": 30, \"active\": true, \"tags\": [\"io\", \"json\"]}"
    
    parsed := JsonParser parse(testJson)
    "Parsed object:" println
    parsed asJson println
    
    "\nPretty printed:" println
    pretty := JsonParser stringify(parsed, 2)
    pretty println
    
    "\nAccessing data:" println
    "Name: " .. (parsed at("name")) println
    "Age: " .. (parsed at("age")) println
    "Tags: " .. (parsed at("tags")) println
)