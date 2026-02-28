
JsonValidator := Object clone do(
    validate := method(jsonString, schema,
        try(
            json := jsonString asJson
            if(json isNil, return false)
            
            if(schema, 
                self validateSchema(json, schema)
            )
            true
        ) catch(e,
            writeln("Validation error: ", e error)
            false
        )
    )
    
    validateSchema := method(json, schema,
        if(schema hasKey("type"),
            expectedType := schema at("type")
            actualType := json type
            
            if(actualType != expectedType,
                Exception raise("Type mismatch: expected #{expectedType}, got #{actualType}" interpolate)
            )
        )
        
        if(schema hasKey("required"),
            requiredFields := schema at("required")
            requiredFields foreach(field,
                if(json hasKey(field) not,
                    Exception raise("Missing required field: #{field}" interpolate)
                )
            )
        )
        
        if(schema hasKey("properties") and json isKindOf(Map),
            properties := schema at("properties")
            json keys foreach(key,
                if(properties hasKey(key),
                    propertySchema := properties at(key)
                    self validateSchema(json at(key), propertySchema)
                )
            )
        )
        
        true
    )
)

JsonValidatorTest := Object clone do(
    run := method(
        validator := JsonValidator clone
        
        testJson := "{\"name\": \"John\", \"age\": 30}"
        schema := Map clone do(
            atPut("type", "Map")
            atPut("required", list("name", "age"))
            atPut("properties", 
                Map clone do(
                    atPut("name", Map clone atPut("type", "Sequence"))
                    atPut("age", Map clone atPut("type", "Number"))
                )
            )
        )
        
        result := validator validate(testJson, schema)
        writeln("Validation result: ", result)
    )
)

if(isLaunchScript, JsonValidatorTest run)