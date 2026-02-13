
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
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            jsonString asMutable replaceSeq("\"", "\"") asMutable replaceSeq("\\", "\\")
            doString("Map clone atPut(\"__json__\", " .. jsonString .. ")") at("__json__")
        ) catch(Exception,
            Exception raise("Invalid JSON: " .. Exception error)
        )
    )

    stringify := method(obj, pretty := false,
        if(obj isNil, return "null")
        if(obj isKindOf(Number), return obj asString)
        if(obj isKindOf(Sequence), return "\"" .. obj asString .. "\"")
        if(obj isKindOf(List),
            items := list()
            obj foreach(item, items append(stringify(item, pretty)))
            return "[" .. items join(if(pretty, ",\n ", ", ")) .. "]"
        )
        if(obj isKindOf(Map),
            pairs := list()
            obj keys foreach(key,
                value := stringify(obj at(key), pretty)
                pairs append("\"" .. key asString .. "\":" .. if(pretty, " ", "") .. value)
            )
            return "{" .. pairs join(if(pretty, ",\n ", ", ")) .. "}"
        )
        Exception raise("Unsupported type for JSON serialization")
    )

    prettyPrint := method(obj,
        stringify(obj, true)
    )
)