
JsonParser := Object clone do(
    parse := method(input,
        input = input strip
        if(input at(0) == "\"", return parseString(input))
        if(input at(0) == "[", return parseArray(input))
        if(input at(0) == "{", return parseObject(input))
        if(input asLowercase == "null", return nil)
        if(input asLowercase == "true", return true)
        if(input asLowercase == "false", return false)
        try(return input asNumber) catch(Exception, Exception raise("Invalid JSON: " .. input))
    )

    parseString := method(input,
        result := ""
        i := 1
        while(i < input size - 1,
            c := input at(i)
            if(c == "\\",
                i = i + 1
                nextChar := input at(i)
                if(nextChar == "\"", result = result .. "\"")
                if(nextChar == "\\", result = result .. "\\")
                if(nextChar == "/", result = result .. "/")
                if(nextChar == "b", result = result .. "\b")
                if(nextChar == "f", result = result .. "\f")
                if(nextChar == "n", result = result .. "\n")
                if(nextChar == "r", result = result .. "\r")
                if(nextChar == "t", result = result .. "\t")
                if(nextChar == "u",
                    hex := input exSlice(i+1, i+5)
                    result = result .. (hex asNumber(16) asCharacter)
                    i = i + 4
                ),
                result = result .. c
            )
            i = i + 1
        )
        result
    )

    parseArray := method(input,
        result := List clone
        content := input exSlice(1, input size - 1) strip
        if(content size == 0, return result)
        
        start := 0
        depth := 0
        inString := false
        escape := false
        
        for(i, 0, content size - 1,
            c := content at(i)
            if(escape, escape = false; continue)
            if(c == "\\", escape = true; continue)
            if(c == "\"", inString = inString not; continue)
            if(inString not,
                if(c == "[", depth = depth + 1)
                if(c == "]", depth = depth - 1)
                if(c == "{", depth = depth + 1)
                if(c == "}", depth = depth - 1)
                if(c == "," and depth == 0,
                    element := content exSlice(start, i) strip
                    result append(parse(element))
                    start = i + 1
                )
            )
        )
        
        lastElement := content exSlice(start) strip
        if(lastElement size > 0, result append(parse(lastElement)))
        result
    )

    parseObject := method(input,
        result := Map clone
        content := input exSlice(1, input size - 1) strip
        if(content size == 0, return result)
        
        start := 0
        depth := 0
        inString := false
        escape := false
        
        for(i, 0, content size - 1,
            c := content at(i)
            if(escape, escape = false; continue)
            if(c == "\\", escape = true; continue)
            if(c == "\"", inString = inString not; continue)
            if(inString not,
                if(c == "[", depth = depth + 1)
                if(c == "]", depth = depth - 1)
                if(c == "{", depth = depth + 1)
                if(c == "}", depth = depth - 1)
                if(c == ":" and depth == 0,
                    key := content exSlice(start, i) strip
                    key = parse(key)
                    
                    valueStart := i + 1
                    valueEnd := content size
                    valueDepth := 0
                    inValueString := false
                    valueEscape := false
                    
                    for(j, i + 1, content size - 1,
                        c2 := content at(j)
                        if(valueEscape, valueEscape = false; continue)
                        if(c2 == "\\", valueEscape = true; continue)
                        if(c2 == "\"", inValueString = inValueString not; continue)
                        if(inValueString not,
                            if(c2 == "[", valueDepth = valueDepth + 1)
                            if(c2 == "]", valueDepth = valueDepth - 1)
                            if(c2 == "{", valueDepth = valueDepth + 1)
                            if(c2 == "}", valueDepth = valueDepth - 1)
                            if(c2 == "," and valueDepth == 0,
                                valueEnd = j
                                break
                            )
                        )
                    )
                    
                    value := content exSlice(valueStart, valueEnd) strip
                    result atPut(key, parse(value))
                    start = valueEnd + 1
                    i = valueEnd
                )
            )
        )
        result
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
        if(cleanString beginsWithSeq("{"),
            parseObject(cleanString)
        elseif(cleanString beginsWithSeq("["),
            parseArray(cleanString)
        else,
            parseValue(cleanString)
        )
    )
    
    parseObject := method(str,
        result := Map clone
        content := str exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content size > 0,
            // Find key
            quoteIndex := content findSeq("\"")
            if(quoteIndex isNil, Exception raise("Invalid object key"))
            
            endQuoteIndex := content findSeq("\"", quoteIndex + 1)
            key := content exSlice(quoteIndex + 1, endQuoteIndex)
            
            // Find colon after key
            colonIndex := content findSeq(":", endQuoteIndex + 1)
            if(colonIndex isNil, Exception raise("Missing colon after key"))
            
            // Parse value
            valueStart := colonIndex + 1
            valueStr := content exSlice(valueStart) strip
            valueResult := parseValue(valueStr)
            
            // Store in map
            result atPut(key, valueResult at("value"))
            
            // Move to next pair or end
            remaining := valueStr exSlice(valueResult at("consumed")) strip
            if(remaining beginsWithSeq(","),
                content := remaining exSlice(1) strip
            else,
                content := ""
            )
        )
        
        result
    )
    
    parseArray := method(str,
        result := List clone
        content := str exSlice(1, -1) strip
        
        if(content isEmpty, return result)
        
        while(content size > 0,
            // Parse array element
            valueResult := parseValue(content)
            result append(valueResult at("value"))
            
            // Move to next element or end
            remaining := content exSlice(valueResult at("consumed")) strip
            if(remaining beginsWithSeq(","),
                content := remaining exSlice(1) strip
            else,
                content := ""
            )
        )
        
        result
    )
    
    parseValue := method(str,
        if(str beginsWithSeq("\""),
            parseString(str)
        elseif(str beginsWithSeq("{"),
            parseObject(str)
        elseif(str beginsWithSeq("["),
            parseArray(str)
        elseif(str beginsWithSeq("true"),
            Map clone atPut("value", true) atPut("consumed", 4)
        elseif(str beginsWithSeq("false"),
            Map clone atPut("value", false) atPut("consumed", 5)
        elseif(str beginsWithSeq("null"),
            Map clone atPut("value", nil) atPut("consumed", 4)
        else,
            parseNumber(str)
        )
    )
    
    parseString := method(str,
        endQuote := str findSeq("\"", 1)
        if(endQuote isNil, Exception raise("Unterminated string"))
        
        value := str exSlice(1, endQuote)
        Map clone atPut("value", value) atPut("consumed", endQuote + 1)
    )
    
    parseNumber := method(str,
        i := 0
        while(i < str size and (str at(i) isDigit or str at(i) == "." or str at(i) == "-" or str at(i) == "e" or str at(i) == "E"),
            i = i + 1
        )
        
        numStr := str exSlice(0, i)
        if(numStr containsSeq("."),
            value := numStr asNumber
        else,
            value := numStr asNumber
        )
        
        Map clone atPut("value", value) atPut("consumed", i)
    )
    
    prettyPrint := method(obj, indent := 0,
        if(obj isKindOf(Map),
            "{\n" \
            .. obj keys map(k, 
                "  " repeated(indent + 1) \
                .. "\"" .. k .. "\": " \
                .. prettyPrint(obj at(k), indent + 1)
            ) join(",\n") \
            .. "\n" .. "  " repeated(indent) .. "}"
        elseif(obj isKindOf(List),
            "[\n" \
            .. obj map(v, 
                "  " repeated(indent + 1) \
                .. prettyPrint(v, indent + 1)
            ) join(",\n") \
            .. "\n" .. "  " repeated(indent) .. "]"
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
    jsonString := "{\"name\": \"test\", \"values\": [1, 2, 3], \"active\": true}"
    
    parser := JsonParser clone
    parsed := parser parse(jsonString)
    
    "Parsed object:" println
    parsed prettyPrint println
    
    "\nAccess values:" println
    "Name: " .. (parsed at("name")) println
    "First value: " .. (parsed at("values") at(0)) println
)