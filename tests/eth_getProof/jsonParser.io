
JsonParser := Object clone do(
    parse := method(jsonString,
        if(jsonString isNil or jsonString isEmpty,
            Exception raise("Empty JSON string")
        )
        
        try(
            doString("(" .. jsonString .. ")")
        ) catch(e,
            Exception raise("Invalid JSON: " .. e error)
        )
    )
    
    prettyPrint := method(obj, indent := 0,
        spaces := "  " repeated(indent)
        nextSpaces := "  " repeated(indent + 1)
        
        if(obj type == "Map",
            "{\n" ..
            obj map(k, v,
                nextSpaces .. "\"" .. k .. "\": " .. prettyPrint(v, indent + 1)
            ) join(",\n") .. "\n" ..
            spaces .. "}"
        ) elseif(obj type == "List",
            "[\n" ..
            obj map(v,
                nextSpaces .. prettyPrint(v, indent + 1)
            ) join(",\n") .. "\n" ..
            spaces .. "]"
        ) elseif(obj type == "Sequence",
            "\"" .. obj .. "\""
        ) else(
            obj asString
        )
    )
    
    fromFile := method(path,
        file := File with(path)
        if(file exists not,
            Exception raise("File not found: " .. path)
        )
        parse(file contents)
    )
)

if(isLaunchScript,
    parser := JsonParser clone
    
    testJson := "{\"name\": \"John\", \"age\": 30, \"hobbies\": [\"reading\", \"coding\"]}"
    
    parsed := parser parse(testJson)
    
    "Original JSON:" println
    testJson println
    
    "\nParsed object type: " print
    parsed type println
    
    "\nPretty printed:" println
    parser prettyPrint(parsed) println
    
    "\nAccessing values:" println
    ("Name: " .. parsed at("name")) println
    ("Age: " .. parsed at("age")) println
    ("First hobby: " .. parsed at("hobbies") at(0)) println
)