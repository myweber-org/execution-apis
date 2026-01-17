
JsonValidator := Object clone do(
    validate := method(jsonString, schema,
        try(
            json := Json parse(jsonString)
            schema validate(json)
            return true
        ) catch(Exception,
            return false
        )
    )
)

JsonSchema := Object clone do(
    init := method(
        self constraints := Map clone
    )
    
    addConstraint := method(key, validationBlock,
        constraints atPut(key, validationBlock)
    )
    
    validate := method(jsonObject,
        constraints foreach(key, block,
            if(jsonObject hasKey(key) not,
                Exception raise("Missing required field: #{key}" interpolate)
            )
            block call(jsonObject at(key))
        )
        true
    )
)

// Example usage
schema := JsonSchema clone
schema addConstraint("name", block(value, if(value type != "string", Exception raise("Name must be string"))))
schema addConstraint("age", block(value, if(value < 0, Exception raise("Age cannot be negative"))))

validator := JsonValidator clone
result := validator validate("{\"name\":\"John\",\"age\":30}", schema)
result println