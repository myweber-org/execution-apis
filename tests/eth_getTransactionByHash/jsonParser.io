
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty, return nil)
        jsonString = jsonString strip
        if(jsonString at(0) == "{", return parseObject(jsonString))
        if(jsonString at(0) == "[", return parseArray(jsonString))
        if(jsonString at(0) == "\"", return parseString(jsonString))
        if(jsonString == "true", return true)
        if(jsonString == "false", return false)
        if(jsonString == "null", return nil)
        if(jsonString contains("."), return jsonString asNumber)
        return jsonString asNumber
    )

    parseObject := method(jsonString,
        result := Map clone
        content := jsonString slice(1, -1) strip
        if(content isEmpty, return result)
        
        while(content notEmpty,
            colonIndex := content findSeq("\":")
            if(colonIndex isNil, break)
            
            key := content slice(0, colonIndex + 1)
            key = parseString(key)
            
            content = content slice(colonIndex + 2) strip
            valueEnd := findValueEnd(content)
            if(valueEnd isNil, break)
            
            valueStr := content slice(0, valueEnd)
            value := parse(valueStr)
            
            result atPut(key, value)
            content = content slice(valueEnd) strip
            if(content at(0) == ",", content = content slice(1) strip)
        )
        result
    )

    parseArray := method(jsonString,
        result := List clone
        content := jsonString slice(1, -1) strip
        if(content isEmpty, return result)
        
        while(content notEmpty,
            valueEnd := findValueEnd(content)
            if(valueEnd isNil, break)
            
            valueStr := content slice(0, valueEnd)
            value := parse(valueStr)
            
            result append(value)
            content = content slice(valueEnd) strip
            if(content at(0) == ",", content = content slice(1) strip)
        )
        result
    )

    parseString := method(jsonString,
        jsonString slice(1, -1) replaceSeq("\\\"", "\"") replaceSeq("\\\\", "\\")
    )

    findValueEnd := method(str,
        str = str strip
        if(str isEmpty, return nil)
        
        if(str at(0) == "\"",
            inEscape := false
            for(i, 1, str size - 1,
                if(str at(i) == "\\", inEscape = true continue)
                if(str at(i) == "\"" and inEscape not,
                    return i + 1
                )
                inEscape = false
            )
            return nil
        )
        
        if(str at(0) == "{",
            braceCount := 1
            for(i, 1, str size - 1,
                if(str at(i) == "{", braceCount = braceCount + 1)
                if(str at(i) == "}", braceCount = braceCount - 1)
                if(braceCount == 0, return i + 1)
            )
            return nil
        )
        
        if(str at(0) == "[",
            bracketCount := 1
            for(i, 1, str size - 1,
                if(str at(i) == "[", bracketCount = bracketCount + 1)
                if(str at(i) == "]", bracketCount = bracketCount - 1)
                if(bracketCount == 0, return i + 1)
            )
            return nil
        )
        
        endChars := list(",", "}", "]")
        for(i, 0, str size - 1,
            if(endChars contains(str at(i) asCharacter), return i)
        )
        str size
    )

    toJson := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Boolean", return if(obj, "true", "false"))
        if(obj type == "Number", return obj asString)
        if(obj type == "Sequence", return "\"" .. obj .. "\"")
        
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            result := "[\n"
            obj foreach(i, v,
                result = result .. "  " repeated(indent + 1) .. toJson(v, indent + 1)
                if(i < obj size - 1, result = result .. ",")
                result = result .. "\n"
            )
            return result .. "  " repeated(indent) .. "]"
        )
        
        if(obj type == "Map",
            if(obj isEmpty, return "{}")
            result := "{\n"
            keys := obj keys
            keys foreach(i, k,
                result = result .. "  " repeated(indent + 1) .. toJson(k, indent + 1) .. ": " .. toJson(obj at(k), indent + 1)
                if(i < keys size - 1, result = result .. ",")
                result = result .. "\n"
            )
            return result .. "  " repeated(indent) .. "}"
        )
        
        obj asString
    )
)

JsonParserTest := Object clone do(
    run := method(
        testJson := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
        
        writeln("Parsing JSON:")
        writeln(testJson)
        writeln()
        
        parsed := JsonParser parse(testJson)
        writeln("Parsed object:")
        parsed keys foreach(k,
            writeln(k, ": ", parsed at(k))
        )
        writeln()
        
        writeln("Back to JSON:")
        writeln(JsonParser toJson(parsed))
    )
)

if(isLaunchScript,
    JsonParserTest run
)