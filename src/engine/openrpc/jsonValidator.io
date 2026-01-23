
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