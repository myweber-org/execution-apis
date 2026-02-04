
JsonValidator := Object clone do(
    validate := method(jsonString, schema,
        try(
            json := doString(jsonString)
            if(json isNil, return Map with("valid", false, "error", "Invalid JSON string"))
            
            result := validateRecursive(json, schema)
            if(result isNil, 
                return Map with("valid", true),
                return Map with("valid", false, "error", result)
            )
        ) catch(Exception,
            return Map with("valid", false, "error", "Parsing error: " .. error)
        )
    )
    
    validateRecursive := method(data, schema,
        if(schema hasKey("type"),
            typeCheck := schema at("type")
            if(typeCheck == "object",
                if(data type != "Map", return "Expected object, got " .. data type)
                if(schema hasKey("properties"),
                    properties := schema at("properties")
                    properties foreach(key, propSchema,
                        if(data hasKey(key) not, 
                            if(propSchema hasKey("required") and propSchema at("required"),
                                return "Missing required field: " .. key
                            )
                        ) else(
                            error := validateRecursive(data at(key), propSchema)
                            if(error, return "Field '" .. key .. "': " .. error)
                        )
                    )
                )
            ) elseif(typeCheck == "array",
                if(data type != "List", return "Expected array, got " .. data type)
                if(schema hasKey("items"),
                    itemSchema := schema at("items")
                    data foreach(index, item,
                        error := validateRecursive(item, itemSchema)
                        if(error, return "Array index " .. index .. ": " .. error)
                    )
                )
            ) elseif(typeCheck == "string",
                if(data type != "Sequence", return "Expected string, got " .. data type)
                if(schema hasKey("pattern"),
                    pattern := schema at("pattern")
                    if(data findRegex(pattern) isNil, return "String doesn't match pattern: " .. pattern)
                )
            ) elseif(typeCheck == "number",
                if(data type != "Number", return "Expected number, got " .. data type)
                if(schema hasKey("minimum"),
                    if(data < schema at("minimum"), return "Number below minimum: " .. schema at("minimum"))
                )
                if(schema hasKey("maximum"),
                    if(data > schema at("maximum"), return "Number above maximum: " .. schema at("maximum"))
                )
            ) elseif(typeCheck == "boolean",
                if(data type != "Boolean", return "Expected boolean, got " .. data type)
            ) elseif(typeCheck == "null",
                if(data != nil, return "Expected null, got " .. data type)
            )
        )
        nil
    )
    
    example := method(
        schema := Map clone do(
            atPut("type", "object")
            atPut("properties", Map clone do(
                atPut("name", Map clone do(
                    atPut("type", "string")
                    atPut("required", true)
                ))
                atPut("age", Map clone do(
                    atPut("type", "number")
                    atPut("minimum", 0)
                    atPut("maximum", 150)
                ))
                atPut("tags", Map clone do(
                    atPut("type", "array")
                    atPut("items", Map clone do(atPut("type", "string")))
                ))
            ))
        )
        
        testJson := "{\"name\":\"John\",\"age\":30,\"tags\":[\"developer\",\"io\"]}"
        result := validate(testJson, schema)
        result println
    )
)