
JsonValidator := Object clone do(
    validate := method(jsonString, schema,
        json := try(doString(jsonString)) catch(e, return "Invalid JSON: #{e}" interpolate)
        validateObject(json, schema)
    )

    validateObject := method(obj, schema,
        schema foreach(key, type,
            if(obj hasSlot(key) not, return "Missing key: #{key}" interpolate)
            value := obj getSlot(key)
            if(type == "string" and value type != "Sequence",
                return "Key #{key} should be string" interpolate
            )
            if(type == "number" and value type != "Number",
                return "Key #{key} should be number" interpolate
            )
            if(type == "boolean" and value type != "True" and value type != "False",
                return "Key #{key} should be boolean" interpolate
            )
            if(type == "array",
                if(value type != "List", return "Key #{key} should be array" interpolate)
                if(schema hasSlot("_items"),
                    value foreach(item,
                        result := validateObject(item, schema getSlot("_items"))
                        if(result != true, return result)
                    )
                )
            )
            if(type == "object",
                if(value type != "Object", return "Key #{key} should be object" interpolate)
                if(schema hasSlot("_properties"),
                    result := validateObject(value, schema getSlot("_properties"))
                    if(result != true, return result)
                )
            )
        )
        true
    )
)
JsonValidator := Object clone do(
    validate := method(jsonString, schema,
        try(
            json := jsonString asJson
            if(json isNil, return false)
            self validateObject(json, schema)
        ) catch(Exception,
            false
        )
    )

    validateObject := method(obj, schema,
        if(schema hasKey("type"),
            if(schema at("type") == "object",
                if(obj isKindOf(Map) not, return false)
                if(schema hasKey("required"),
                    requiredFields := schema at("required")
                    requiredFields foreach(field,
                        if(obj hasKey(field) not, return false)
                    )
                )
                if(schema hasKey("properties"),
                    properties := schema at("properties")
                    obj foreach(key, value,
                        if(properties hasKey(key),
                            propertySchema := properties at(key)
                            if(self validateValue(value, propertySchema) not,
                                return false
                            )
                        )
                    )
                )
                return true
            )
        )
        false
    )

    validateValue := method(value, schema,
        if(schema hasKey("type"),
            type := schema at("type")
            if(type == "string",
                return value isKindOf(Sequence)
            )
            if(type == "number",
                return value isKindOf(Number)
            )
            if(type == "boolean",
                return value isKindOf(Number) and (value == 0 or value == 1)
            )
            if(type == "array",
                return value isKindOf(List) and 
                    value all(item, self validateValue(item, schema at("items")))
            )
            if(type == "object",
                return self validateObject(value, schema)
            )
        )
        false
    )
)