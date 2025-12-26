
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty,
            Exception raise("Empty JSON string")
        )
        
        // Remove whitespace
        jsonString := jsonString strip
        
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
        
        // Try parsing as number or boolean
        if(jsonString asNumber != nil,
            return jsonString asNumber
        )
        
        if(jsonString == "true", return true)
        if(jsonString == "false", return false)
        if(jsonString == "null", return nil)
        
        Exception raise("Invalid JSON: " .. jsonString)
    )
    
    parseObject := method(jsonString,
        result := Map clone
        content := jsonString slice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content notEmpty,
            // Find key
            quoteIndex := content findSeq("\"")
            if(quoteIndex == nil,
                Exception raise("Expected '\"' in object key")
            )
            
            endQuoteIndex := content findSeq("\"", quoteIndex + 1)
            if(endQuoteIndex == nil,
                Exception raise("Unterminated string in object key")
            )
            
            key := content slice(quoteIndex + 1, endQuoteIndex)
            
            // Find colon
            colonIndex := content findSeq(":", endQuoteIndex + 1)
            if(colonIndex == nil,
                Exception raise("Expected ':' after object key")
            )
            
            // Parse value
            valueStart := colonIndex + 1
            valueStr := content slice(valueStart) strip
            valueResult := parseValue(valueStr)
            
            result atPut(key, valueResult first)
            
            // Update content for next iteration
            remaining := valueStr slice(valueResult second) strip
            if(remaining beginsWithSeq(","),
                content := remaining slice(1) strip
            ,
                content := ""
            )
        )
        
        result
    )
    
    parseArray := method(jsonString,
        result := List clone
        content := jsonString slice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content notEmpty,
            valueResult := parseValue(content)
            result append(valueResult first)
            
            remaining := content slice(valueResult second) strip
            if(remaining beginsWithSeq(","),
                content := remaining slice(1) strip
            ,
                content := ""
            )
        )
        
        result
    )
    
    parseString := method(jsonString,
        endQuote := jsonString findSeq("\"", 1)
        if(endQuote == nil,
            Exception raise("Unterminated string")
        )
        
        str := jsonString slice(1, endQuote)
        [str, endQuote + 1]
    )
    
    parseValue := method(str,
        if(str beginsWithSeq("{"),
            obj := parseObject(str)
            [obj, findMatchingBrace(str, "{", "}")]
        )
        if(str beginsWithSeq("["),
            arr := parseArray(str)
            [arr, findMatchingBrace(str, "[", "]")]
        )
        if(str beginsWithSeq("\""),
            return parseString(str)
        )
        
        // Parse primitive values
        commaIndex := str findSeq(",")
        spaceIndex := str findSeq(" ")
        endIndex := str size
        
        if(commaIndex != nil, endIndex = commaIndex)
        if(spaceIndex != nil and spaceIndex < endIndex, endIndex = spaceIndex)
        
        valueStr := str slice(0, endIndex)
        value := parse(valueStr)
        
        [value, endIndex]
    )
    
    findMatchingBrace := method(str, openBrace, closeBrace,
        count := 1
        i := 1
        
        while(i < str size and count > 0,
            if(str at(i) asCharacter == openBrace,
                count = count + 1
            )
            if(str at(i) asCharacter == closeBrace,
                count = count - 1
            )
            i = i + 1
        )
        
        if(count != 0,
            Exception raise("Unbalanced braces")
        )
        
        i
    )
    
    prettyPrint := method(obj, indent := 0,
        if(obj isKindOf(Map),
            "{\n" print
            obj keys foreach(i, key,
                "  " repeated(indent + 1) print
                "\"" .. key .. "\": " print
                prettyPrint(obj at(key), indent + 1)
                if(i < obj size - 1, ",\n" print, "\n" print)
            )
            "  " repeated(indent) .. "}" print
        )
        if(obj isKindOf(List),
            "[\n" print
            obj foreach(i, item,
                "  " repeated(indent + 1) print
                prettyPrint(item, indent + 1)
                if(i < obj size - 1, ",\n" print, "\n" print)
            )
            "  " repeated(indent) .. "]" print
        )
        if(obj isKindOf(Sequence),
            "\"" .. obj .. "\"" print
        )
        if(obj isKindOf(Number) or obj isKindOf(Number) == false,
            obj asString print
        )
        if(obj isNil, "null" print)
    )
)

// Example usage
jsonString := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
parsed := JsonParser parse(jsonString)
"Parsed object:\n" print
JsonParser prettyPrint(parsed)
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
            obj serialized
        ,
            obj asJson
        )
    )
    
    prettyPrint := method(obj,
        obj serialized
    )
)

JsonParserTest := Object clone do(
    testParse := method(
        json := JsonParser parse("{\"name\":\"Alice\",\"age\":30}")
        json at("name") println
        json at("age") println
    )
    
    testStringify := method(
        obj := Map clone
        obj atPut("city", "New York")
        obj atPut("population", 8000000)
        JsonParser stringify(obj, true) println
    )
)

if(isLaunchScript,
    JsonParserTest testParse
    JsonParserTest testStringify
)