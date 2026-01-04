
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
    run := method(
        jsonStr := "{\"name\":\"Io\",\"version\":\"2023.11\",\"features\":[\"prototype\",\"coroutine\"]}"
        
        parsed := JsonParser parse(jsonStr)
        writeln("Parsed: ", parsed)
        
        writeln("\nPretty printed:")
        writeln(JsonParser prettyPrint(parsed))
        
        writeln("\nCompact JSON:")
        writeln(JsonParser stringify(parsed))
    )
)

if(isLaunchScript,
    JsonParserTest run
)