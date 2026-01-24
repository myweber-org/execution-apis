
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            doString("(" .. jsonString .. ")")
        ) catch(e,
            Exception raise("Invalid JSON: " .. e error)
        )
    )

    stringify := method(obj, pretty := false,
        if(pretty,
            prettyPrint(obj, 0)
        ,
            compactPrint(obj)
        )
    )

    prettyPrint := method(obj, indentLevel,
        indent := "  " repeated(indentLevel)
        nextIndent := "  " repeated(indentLevel + 1)
        
        if(obj isKindOf(Map),
            "{\n" ..
            obj map(k, v,
                nextIndent .. "\"" .. k .. "\": " .. prettyPrint(v, indentLevel + 1)
            ) join(",\n") ..
            "\n" .. indent .. "}"
        ,
        if(obj isKindOf(List),
            "[\n" ..
            obj map(v,
                nextIndent .. prettyPrint(v, indentLevel + 1)
            ) join(",\n") ..
            "\n" .. indent .. "]"
        ,
        if(obj isKindOf(Sequence),
            "\"" .. obj .. "\""
        ,
            obj asString
        )))
    )

    compactPrint := method(obj,
        if(obj isKindOf(Map),
            "{" ..
            obj map(k, v,
                "\"" .. k .. "\":" .. compactPrint(v)
            ) join(",") ..
            "}"
        ,
        if(obj isKindOf(List),
            "[" ..
            obj map(v,
                compactPrint(v)
            ) join(",") ..
            "]"
        ,
        if(obj isKindOf(Sequence),
            "\"" .. obj .. "\""
        ,
            obj asString
        )))
    )

    validate := method(jsonString,
        try(
            parse(jsonString)
            true
        ) catch(e,
            false
        )
    )
)