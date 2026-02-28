
JsonParser := Object clone do(
    parse := method(jsonString,
        try(
            jsonString asMutable replaceSeq("\"", "\"") replaceSeq("\\", "\\")
            doString("Map clone atPut(\"__json__\", " .. jsonString .. ")") at("__json__")
        ) catch(Exception,
            Exception raise("Invalid JSON: " .. Exception error)
        )
    )

    stringify := method(obj, pretty := false,
        if(obj isNil, return "null")
        if(obj isKindOf(Number), return obj asString)
        if(obj isKindOf(Sequence), return "\"" .. obj .. "\"")
        if(obj isKindOf(List),
            items := obj map(item, stringify(item, pretty))
            if(pretty,
                "[\n" .. items join(",\n") split("\n") map(line, "  " .. line) join("\n") .. "\n]"
            ,
                "[" .. items join(", ") .. "]"
            )
        )
        if(obj isKindOf(Map),
            pairs := obj map(key, value,
                "\"" .. key .. "\": " .. stringify(value, pretty)
            )
            if(pretty,
                "{\n" .. pairs join(",\n") split("\n") map(line, "  " .. line) join("\n") .. "\n}"
            ,
                "{" .. pairs join(", ") .. "}"
            )
        )
        Exception raise("Unsupported type for JSON serialization")
    )

    prettyPrint := method(obj,
        writeln(stringify(obj, true))
    )
)