
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
            obj serialized(0, "  ")
        ,
            obj serialized
        )
    )
    
    prettyPrint := method(obj,
        stringify(obj, true) println
    )
)

// Example usage
parser := JsonParser clone
data := parser parse("{\"name\": \"John\", \"age\": 30, \"city\": \"New York\"}")
parser prettyPrint(data)