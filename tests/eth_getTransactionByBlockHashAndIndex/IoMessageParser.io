
IoMessageParser := Object clone do(
    parse := method(message,
        if(message isNil, return nil)
        
        parsed := Map clone
        message split("\n") foreach(i, line,
            if(line containsSeq(": "),
                parts := line split(": ")
                if(parts size >= 2,
                    key := parts at(0) strip
                    value := parts at(1) strip
                    parsed atPut(key, value)
                )
            )
        )
        parsed
    )
    
    validate := method(parsedMap,
        requiredKeys := list("type", "sender", "timestamp")
        requiredKeys foreach(key,
            if(parsedMap at(key) isNil,
                Exception raise("Missing required field: #{key}" interpolate)
            )
        )
        true
    )
    
    process := method(message,
        parsed := parse(message)
        if(parsed isNil, return nil)
        
        validate(parsed)
        
        result := Map clone
        result atPut("original", message)
        result atPut("parsed", parsed)
        result atPut("processed_at", Date now asString)
        
        result
    )
)

// Example usage
parser := IoMessageParser clone
testMessage := "type: notification\nsender: system\ntimestamp: 2024-01-15T10:30:00\ncontent: System update completed"

result := parser process(testMessage)
if(result,
    "Parsed successfully: #{result at(\"processed_at\")}" interpolate println
    result at("parsed") keys foreach(key,
        "#{key}: #{result at(\"parsed\") at(key)}" interpolate println
    )
)