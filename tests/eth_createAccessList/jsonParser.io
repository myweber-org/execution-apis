
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty, return nil)
        
        try(
            jsonString strip
            if(jsonString beginsWithSeq("{"), return parseObject(jsonString))
            if(jsonString beginsWithSeq("["), return parseArray(jsonString))
            if(jsonString beginsWithSeq("\""), return parseString(jsonString))
            if(jsonString asLowercase == "null", return nil)
            if(jsonString asLowercase == "true", return true)
            if(jsonString asLowercase == "false", return false)
            
            number := jsonString asNumber
            if(number isNan, Exception raise("Invalid JSON: " .. jsonString))
            return number
        ) catch(Exception,
            Exception raise("JSON parsing failed: " .. exception error)
        )
    )
    
    parseObject := method(jsonString,
        result := Map clone
        content := jsonString exSlice(1, -1) strip
        
        while(content size > 0,
            keyEnd := findStringEnd(content, 0)
            key := parseString(content exSlice(0, keyEnd))
            
            colonPos := content findSeq(":", keyEnd)
            if(colonPos == nil, Exception raise("Missing colon in object"))
            
            valueStart := colonPos + 1
            while(valueStart < content size and content at(valueStart) isSpace,
                valueStart = valueStart + 1
            )
            
            valueEnd := findValueEnd(content, valueStart)
            value := parse(content exSlice(valueStart, valueEnd))
            
            result atPut(key, value)
            
            nextPos := valueEnd
            while(nextPos < content size and content at(nextPos) isSpace,
                nextPos = nextPos + 1
            )
            
            if(nextPos >= content size, break)
            
            if(content at(nextPos) == ',',
                content = content exSlice(nextPos + 1) strip
            ,
                Exception raise("Expected comma in object")
            )
        )
        
        return result
    )
    
    parseArray := method(jsonString,
        result := List clone
        content := jsonString exSlice(1, -1) strip
        
        while(content size > 0,
            valueEnd := findValueEnd(content, 0)
            value := parse(content exSlice(0, valueEnd))
            result append(value)
            
            nextPos := valueEnd
            while(nextPos < content size and content at(nextPos) isSpace,
                nextPos = nextPos + 1
            )
            
            if(nextPos >= content size, break)
            
            if(content at(nextPos) == ',',
                content = content exSlice(nextPos + 1) strip
            ,
                Exception raise("Expected comma in array")
            )
        )
        
        return result
    )
    
    parseString := method(jsonString,
        result := ""
        i := 1
        while(i < jsonString size - 1,
            ch := jsonString at(i)
            if(ch == '\\',
                i = i + 1
                if(i >= jsonString size - 1, break)
                
                nextChar := jsonString at(i)
                if(nextChar == '"', result = result .. "\"")
                if(nextChar == '\\', result = result .. "\\")
                if(nextChar == '/', result = result .. "/")
                if(nextChar == 'b', result = result .. "\b")
                if(nextChar == 'f', result = result .. "\f")
                if(nextChar == 'n', result = result .. "\n")
                if(nextChar == 'r', result = result .. "\r")
                if(nextChar == 't', result = result .. "\t")
                if(nextChar == 'u',
                    hex := jsonString exSlice(i + 1, i + 5)
                    if(hex size != 4, Exception raise("Invalid Unicode escape"))
                    result = result .. (hex asNumber(16) asCharacter)
                    i = i + 4
                )
            ,
                result = result .. (ch asCharacter)
            )
            i = i + 1
        )
        return result
    )
    
    findStringEnd := method(str, start,
        if(str at(start) != '"', Exception raise("Expected string"))
        
        i := start + 1
        while(i < str size,
            if(str at(i) == '"' and str at(i-1) != '\\',
                return i + 1
            )
            i = i + 1
        )
        Exception raise("Unterminated string")
    )
    
    findValueEnd := method(str, start,
        i := start
        while(i < str size,
            ch := str at(i)
            
            if(ch == '"',
                return findStringEnd(str, i)
            )
            
            if(ch == '{' or ch == '[',
                depth := 1
                i = i + 1
                while(i < str size and depth > 0,
                    nextCh := str at(i)
                    if(nextCh == ch, depth = depth + 1)
                    if((ch == '{' and nextCh == '}') or (ch == '[' and nextCh == ']'),
                        depth = depth - 1
                    )
                    if(depth == 0, return i + 1)
                    i = i + 1
                )
                Exception raise("Unterminated object or array")
            )
            
            if(ch == ',' or ch == '}' or ch == ']',
                return i
            )
            
            i = i + 1
        )
        return str size
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Boolean", return if(obj, "true", "false"))
        if(obj type == "Number", return obj asString)
        if(obj type == "Sequence", return "\"" .. escapeString(obj) .. "\"")
        
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
            first := true
            
            obj keys sort foreach(key,
                if(first not, result = result .. ",")
                first = false
                
                result = result .. "\n" .. spaces .. "\"" .. escapeString(key) .. "\": " .. 
                        stringify(obj at(key), indent + 2)
            )
            
            return result .. "\n" .. " " repeated(indent) .. "}"
        )
        
        Exception raise("Unsupported type for JSON serialization: " .. obj type)
    )
    
    escapeString := method(str,
        result := ""
        str foreach(i, ch,
            if(ch == '"', result = result .. "\\\"")
            if(ch == '\\', result = result .. "\\\\")
            if(ch == '\b', result = result .. "\\b")
            if(ch == '\f', result = result .. "\\f")
            if(ch == '\n', result = result .. "\\n")
            if(ch == '\r', result = result .. "\\r")
            if(ch == '\t', result = result .. "\\t")
            if(ch >= ' ' and ch <= '~' and ch != '"' and ch != '\\',
                result = result .. ch
            ,
                hex := ch asNumber asString(16) asUpper
                while(hex size < 4, hex = "0" .. hex)
                result = result .. "\\u" .. hex
            )
        )
        return result
    )
    
    prettyPrint := method(obj,
        writeln(stringify(obj))
    )
)