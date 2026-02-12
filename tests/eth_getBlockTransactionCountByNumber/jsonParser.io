
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            jsonString asMutable replaceSeq("\"", "\"") asJson
        ) catch(Exception,
            Exception raise("Invalid JSON: " .. jsonString)
        )
    )

    prettyPrint := method(jsonObject, indent := 0,
        spaces := "  " repeated(indent)
        if(jsonObject isKindOf(Map),
            "{\n" ..
            jsonObject map(k, v,
                spaces .. "  \"" .. k .. "\": " .. prettyPrint(v, indent + 1)
            ) join(",\n") ..
            "\n" .. spaces .. "}"
        ) elseif(jsonObject isKindOf(List),
            "[\n" ..
            jsonObject map(v,
                spaces .. "  " .. prettyPrint(v, indent + 1)
            ) join(",\n") ..
            "\n" .. spaces .. "]"
        ) elseif(jsonObject isKindOf(Sequence),
            "\"" .. jsonObject .. "\""
        ) else(
            jsonObject asString
        )
    )
)

// Example usage
testJson := "{\"name\":\"John\",\"age\":30,\"cities\":[\"New York\",\"London\"]}"
parsed := JsonParser parse(testJson)
JsonParser prettyPrint(parsed) println