
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