
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty,
            Exception raise("Empty JSON string")
        )
        
        // Remove whitespace
        cleanString := jsonString asMutable strip
        
        // Validate basic structure
        if(cleanString beginsWithSeq("{") not and cleanString beginsWithSeq("[") not,
            Exception raise("Invalid JSON: must start with { or [")
        )
        
        // Simple parsing logic (simplified for example)
        if(cleanString beginsWithSeq("{"),
            self parseObject(cleanString)
        else,
            self parseArray(cleanString)
        )
    )
    
    parseObject := method(str,
        result := Map clone
        // Simplified parsing - real implementation would be more complex
        content := str exSlice(1, -1)
        if(content isEmpty, return result)
        
        pairs := content split(",")
        pairs foreach(pair,
            keyValue := pair split(":")
            if(keyValue size != 2,
                Exception raise("Invalid key-value pair: " .. pair)
            )
            
            key := keyValue at(0) asMutable strip exSlice(1, -1)
            value := self parseValue(keyValue at(1) asMutable strip)
            result atPut(key, value)
        )
        
        result
    )
    
    parseArray := method(str,
        result := List clone
        content := str exSlice(1, -1)
        if(content isEmpty, return result)
        
        items := content split(",")
        items foreach(item,
            result append(self parseValue(item asMutable strip))
        )
        
        result
    )
    
    parseValue := method(str,
        if(str beginsWithSeq("\""),
            return str exSlice(1, -1)
        )
        
        if(str == "true", return true)
        if(str == "false", return false)
        if(str == "null", return nil)
        
        // Try parsing as number
        try(
            return str asNumber
        ) catch(Exception,
            Exception raise("Invalid JSON value: " .. str)
        )
    )
    
    stringify := method(obj, indent := 0,
        if(obj isNil, return "null")
        if(obj type == "Block", return "\"[Block]\"")
        
        if(obj type == "Sequence",
            return "\"" .. obj .. "\""
        )
        
        if(obj type == "Number",
            return obj asString
        )
        
        if(obj type == "Boolean",
            return if(obj, "true", "false")
        )
        
        if(obj type == "List",
            if(obj isEmpty, return "[]")
            
            result := "["
            obj foreach(i, item,
                if(i > 0, result = result .. ", ")
                result = result .. self stringify(item, indent)
            )
            result = result .. "]"
            return result
        )
        
        if(obj type == "Map",
            if(obj isEmpty, return "{}")
            
            result := "{"
            first := true
            obj keys foreach(key,
                if(first not, result = result .. ", ")
                first = false
                
                result = result .. "\"" .. key .. "\": " .. self stringify(obj at(key), indent)
            )
            result = result .. "}"
            return result
        )
        
        return "\"" .. obj asString .. "\""
    )
    
    prettyPrint := method(obj, indentLevel := 0,
        jsonString := self stringify(obj)
        // Simple pretty printing by adding indentation
        result := ""
        currentIndent := 0
        
        jsonString foreach(i, char,
            if(char == '{' or char == '['),
                result = result .. char .. "\n" .. ("  " repeated((currentIndent + 1)))
                currentIndent = currentIndent + 1
            elseif(char == '}' or char == ']'),
                currentIndent = currentIndent - 1
                result = result .. "\n" .. ("  " repeated(currentIndent)) .. char
            elseif(char == ','),
                result = result .. char .. "\n" .. ("  " repeated(currentIndent))
            else,
                result = result .. char
        )
        
        result
    )
)

// Example usage
if(isLaunchScript,
    parser := JsonParser clone
    
    testJson := "{\"name\": \"John\", \"age\": 30, \"active\": true}"
    
    writeln("Parsing JSON:")
    parsed := parser parse(testJson)
    parsed keys foreach(key,
        writeln(key, ": ", parsed at(key))
    )
    
    writeln("\nPretty printed:")
    writeln(parser prettyPrint(parsed))
)