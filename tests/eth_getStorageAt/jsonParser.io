
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
            obj serialized(0)
        ,
            obj serialized
        )
    )
    
    prettyPrint := method(jsonString,
        obj := parse(jsonString)
        stringify(obj, true)
    )
)
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty, return nil)
        jsonString = jsonString strip
        if(jsonString at(0) == '{', return parseObject(jsonString))
        if(jsonString at(0) == '[', return parseArray(jsonString))
        if(jsonString at(0) == '"', return parseString(jsonString))
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
            keyStart := content findSeq("\"")
            if(keyStart isNil, Exception raise("Invalid JSON: missing key"))
            
            keyEnd := content findSeq("\"", keyStart + 1)
            if(keyEnd isNil, Exception raise("Invalid JSON: unclosed key"))
            
            key := content slice(keyStart + 1, keyEnd)
            content = content slice(keyEnd + 1) strip
            
            if(content at(0) != ':', Exception raise("Invalid JSON: missing colon"))
            content = content slice(1) strip
            
            valueEnd := findValueEnd(content)
            valueStr := content slice(0, valueEnd)
            value := parse(valueStr)
            
            result atPut(key, value)
            content = content slice(valueEnd) strip
            
            if(content notEmpty and content at(0) == ',',
                content = content slice(1) strip
            )
        )
        result
    )

    parseArray := method(jsonString,
        result := List clone
        content := jsonString slice(1, -1) strip
        if(content isEmpty, return result)
        
        while(content notEmpty,
            valueEnd := findValueEnd(content)
            valueStr := content slice(0, valueEnd)
            value := parse(valueStr)
            result append(value)
            
            content = content slice(valueEnd) strip
            if(content notEmpty and content at(0) == ',',
                content = content slice(1) strip
            )
        )
        result
    )

    parseString := method(jsonString,
        content := jsonString slice(1, -1)
        content replaceSeq("\\\"", "\"") replaceSeq("\\\\", "\\")
    )

    findValueEnd := method(str,
        str = str strip
        if(str at(0) == '{', return findMatchingBrace(str, '{', '}'))
        if(str at(0) == '[', return findMatchingBrace(str, '[', ']'))
        if(str at(0) == '"',
            endPos := 1
            while(endPos < str size,
                if(str at(endPos) == '"' and str at(endPos - 1) != '\\',
                    return endPos + 1
                )
                endPos = endPos + 1
            )
            Exception raise("Invalid JSON: unclosed string")
        )
        
        commaPos := str findSeq(",")
        if(commaPos isNil, return str size)
        return commaPos
    )

    findMatchingBrace := method(str, openBrace, closeBrace,
        count := 1
        pos := 1
        while(pos < str size and count > 0,
            if(str at(pos) == openBrace, count = count + 1)
            if(str at(pos) == closeBrace, count = count - 1)
            pos = pos + 1
        )
        if(count != 0, Exception raise("Invalid JSON: mismatched braces"))
        pos
    )

    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Boolean", return if(obj, "true", "false"))
        if(obj type == "Number", return obj asString)
        if(obj type == "Sequence", return "\"" .. obj .. "\"")
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            result := "["
            spaces := " " repeated(indent + 2)
            obj foreach(i, item,
                if(i > 0, result = result .. ",")
                result = result .. "\n" .. spaces .. stringify(item, indent + 2)
            )
            return result .. "\n" .. " " repeated(indent) .. "]"
        )
        if(obj type == "Map",
            if(obj isEmpty, return "{}")
            result := "{"
            spaces := " " repeated(indent + 2)
            keys := obj keys sort
            keys foreach(i, key,
                if(i > 0, result = result .. ",")
                value := obj at(key)
                result = result .. "\n" .. spaces .. "\"" .. key .. "\": " .. stringify(value, indent + 2)
            )
            return result .. "\n" .. " " repeated(indent) .. "}"
        )
        Exception raise("Unsupported type for JSON serialization")
    )
)

if(isLaunchScript,
    parser := JsonParser clone
    
    testJson := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    
    parsed := parser parse(testJson)
    "Parsed object:" println
    parsed asJson println
    
    "\nSerialized back to JSON:" println
    serialized := parser stringify(parsed)
    serialized println
    
    "\nPretty printed:" println
    pretty := parser stringify(parsed, 2)
    pretty println
)