
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
        
        // Simple parsing logic (simplified for example)
        if(cleanString at(0) == "{",
            self parseObject(cleanString)
        else,
            self parseArray(cleanString)
        )
    )
    
    parseObject := method(str,
        result := Map clone
        // Remove outer braces
        content := str exSlice(1, str size - 2)
        
        // Simple key-value parsing
        pairs := content split(",")
        pairs foreach(pair,
            if(pair isEmpty, continue)
            keyValue := pair split(":")
            if(keyValue size != 2, 
                Exception raise("Invalid key-value pair: " .. pair)
            )
            
            key := keyValue at(0) asMutable strip
            value := keyValue at(1) asMutable strip
            
            // Remove quotes from key
            if(key at(0) == "\"", key = key exSlice(1, key size - 2))
            
            // Parse value based on type
            parsedValue := self parseValue(value)
            result atPut(key, parsedValue)
        )
        
        result
    )
    
    parseArray := method(str,
        result := List clone
        content := str exSlice(1, str size - 2)
        
        if(content isEmpty, return result)
        
        items := content split(",")
        items foreach(item,
            if(item isEmpty, continue)
            parsedItem := self parseValue(item strip)
            result append(parsedItem)
        )
        
        result
    )
    
    parseValue := method(valueStr,
        if(valueStr at(0) == "\"",
            // String
            return valueStr exSlice(1, valueStr size - 2)
        )
        
        if(valueStr == "true", return true)
        if(valueStr == "false", return false)
        if(valueStr == "null", return nil)
        
        // Try parsing as number
        if(valueStr contains("."),
            return valueStr asNumber
        else,
            return valueStr asNumber
        )
    )
    
    prettyPrint := method(parsedObject, indentLevel := 0,
        indent := "  " repeated(indentLevel)
        
        if(parsedObject type == "Map",
            result := "{\n"
            count := 0
            parsedObject keys foreach(key,
                if(count > 0, result = result .. ",\n")
                result = result .. indent .. "  \"" .. key .. "\": "
                value := parsedObject at(key)
                result = result .. self prettyPrint(value, indentLevel + 1)
                count = count + 1
            )
            result = result .. "\n" .. indent .. "}"
            return result
        )
        
        if(parsedObject type == "List",
            result := "[\n"
            count := 0
            parsedObject foreach(item,
                if(count > 0, result = result .. ",\n")
                result = result .. indent .. "  " .. self prettyPrint(item, indentLevel + 1)
                count = count + 1
            )
            result = result .. "\n" .. indent .. "]"
            return result
        )
        
        if(parsedObject isNil, return "null")
        if(parsedObject type == "Sequence", return "\"" .. parsedObject .. "\"")
        return parsedObject asString
    )
)

// Example usage
if(isLaunchScript,
    testJson := "{\"name\": \"John\", \"age\": 30, \"active\": true, \"tags\": [\"io\", \"json\"]}"
    
    parser := JsonParser clone
    parsed := parser parse(testJson)
    
    "Parsed object:" println
    parsed asJson println
    
    "\nPretty printed:" println
    parser prettyPrint(parsed) println
)