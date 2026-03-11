
JsonParser := Object clone do(
    parse := method(jsonString,
        tokens := tokenize(jsonString)
        if(tokens size == 0, return nil)
        parseValue(tokens)
    )
    
    tokenize := method(jsonString,
        tokens := List clone
        i := 0
        while(i < jsonString size,
            ch := jsonString at(i)
            if(ch == "{" or ch == "}" or ch == "[" or ch == "]" or ch == ":" or ch == ",",
                tokens append(ch asString)
                i = i + 1
            ) elseif(ch == "\"",
                start := i
                i = i + 1
                while(i < jsonString size and jsonString at(i) != "\"",
                    if(jsonString at(i) == "\\", i = i + 1)
                    i = i + 1
                )
                if(i < jsonString size,
                    tokens append(jsonString slice(start, i + 1))
                    i = i + 1
                )
            ) elseif(ch isDigit or ch == "-",
                start := i
                while(i < jsonString size and (jsonString at(i) isDigit or jsonString at(i) == "." or jsonString at(i) == "e" or jsonString at(i) == "E" or jsonString at(i) == "+" or jsonString at(i) == "-"),
                    i = i + 1
                )
                tokens append(jsonString slice(start, i))
            ) elseif(ch isLetter,
                start := i
                while(i < jsonString size and jsonString at(i) isLetter,
                    i = i + 1
                )
                word := jsonString slice(start, i)
                if(word == "true" or word == "false" or word == "null",
                    tokens append(word)
                )
            ) else(
                i = i + 1
            )
        )
        tokens
    )
    
    parseValue := method(tokens,
        if(tokens size == 0, return nil)
        token := tokens removeFirst
        if(token == "{", return parseObject(tokens))
        if(token == "[", return parseArray(tokens))
        if(token beginsWith("\""), return token slice(1, token size - 1))
        if(token contains(".") or token contains("e") or token contains("E"),
            return token asNumber
        )
        if(token isDigit or (token beginsWith("-") and token slice(1) isDigit),
            return token asNumber
        )
        if(token == "true", return true)
        if(token == "false", return false)
        if(token == "null", return nil)
        nil
    )
    
    parseObject := method(tokens,
        obj := Map clone
        while(tokens size > 0 and tokens first != "}",
            keyToken := tokens removeFirst
            if(not keyToken beginsWith("\""), break)
            key := keyToken slice(1, keyToken size - 1)
            if(tokens size == 0 or tokens removeFirst != ":", break)
            value := parseValue(tokens)
            obj atPut(key, value)
            if(tokens size > 0 and tokens first == ",",
                tokens removeFirst
            )
        )
        if(tokens size > 0 and tokens first == "}", tokens removeFirst)
        obj
    )
    
    parseArray := method(tokens,
        arr := List clone
        while(tokens size > 0 and tokens first != "]",
            value := parseValue(tokens)
            arr append(value)
            if(tokens size > 0 and tokens first == ",",
                tokens removeFirst
            )
        )
        if(tokens size > 0 and tokens first == "]", tokens removeFirst)
        arr
    )
)