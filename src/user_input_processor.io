
UserInputProcessor := Object clone do(
    process := method(input,
        if(input isNil or input asString isEmpty, 
            return nil,
            return input asString strip asLowercase
        )
    )
    
    validateLength := method(input, minLength, maxLength,
        if(input isNil, return false)
        length := input asString size
        return length >= minLength and length <= maxLength
    )
    
    sanitize := method(input,
        if(input isNil, return "")
        input asString replaceSeq("\"", "&quot;") replaceSeq("'", "&#39;")
    )
)

processor := UserInputProcessor clone
testInput := "  Hello WORLD  "
processed := processor process(testInput)
valid := processor validateLength(processed, 1, 50)
sanitized := processor sanitize(processed)