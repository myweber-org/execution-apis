
JsonParser := Object clone do(
    parse := method(jsonString,
        jsonString = jsonString strip
        if(jsonString at(0) == "{", return parseObject(jsonString))
        if(jsonString at(0) == "[", return parseArray(jsonString))
        Exception raise("Invalid JSON: must start with { or [")
    )
    
    parseObject := method(str,
        str = str slice(1, -1) strip
        if(str size == 0, return Map clone)
        
        obj := Map clone
        while(str size > 0,
            key := parseString(str)
            str = str slice(key size + 2) strip
            if(str at(0) != ':', Exception raise("Expected ':' after key"))
            str = str slice(1) strip
            
            value := parseValue(str)
            obj atPut(key, value)
            
            str = str slice(value asString size) strip
            if(str size > 0,
                if(str at(0) != ',', Exception raise("Expected ',' between pairs"))
                str = str slice(1) strip
            )
        )
        obj
    )
    
    parseArray := method(str,
        str = str slice(1, -1) strip
        if(str size == 0, return List clone)
        
        arr := List clone
        while(str size > 0,
            value := parseValue(str)
            arr append(value)
            
            str = str slice(value asString size) strip
            if(str size > 0,
                if(str at(0) != ',', Exception raise("Expected ',' between elements"))
                str = str slice(1) strip
            )
        )
        arr
    )
    
    parseValue := method(str,
        if(str at(0) == "{", return parseObject(str))
        if(str at(0) == "[", return parseArray(str))
        if(str at(0) == '"', return parseString(str))
        if(str at(0) isDigit or str at(0) == '-', return parseNumber(str))
        if(str beginsWith("true"), return true)
        if(str beginsWith("false"), return false)
        if(str beginsWith("null"), return nil)
        Exception raise("Invalid JSON value")
    )
    
    parseString := method(str,
        end := 1
        while(str at(end) != '"' or str at(end-1) == '\\',
            end = end + 1
            if(end >= str size, Exception raise("Unterminated string"))
        )
        str slice(1, end)
    )
    
    parseNumber := method(str,
        end := 0
        while(str at(end) isDigit or str at(end) inList(list('.', '-', 'e', 'E')),
            end = end + 1
            if(end >= str size, break)
        )
        str slice(0, end) asNumber
    )
)

JsonParserTest := Object clone do(
    run := method(
        testJson := "{\"name\": \"John\", \"age\": 30, \"active\": true, \"tags\": [\"io\", \"json\"], \"address\": {\"city\": \"NYC\"}}"
        
        parsed := JsonParser parse(testJson)
        writeln("Parsed object: ", parsed)
        writeln("Name: ", parsed at("name"))
        writeln("Age: ", parsed at("age"))
        writeln("Active: ", parsed at("active"))
        writeln("Tags: ", parsed at("tags"))
        writeln("City: ", parsed at("address") at("city"))
    )
)

if(isLaunchScript, JsonParserTest run)