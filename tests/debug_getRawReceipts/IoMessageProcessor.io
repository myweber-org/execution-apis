
MessageProcessor := Object clone do(
    formatMessage := method(message,
        "Processed: " .. message asUppercase
    )
    
    logMessage := method(message,
        writeln("Log: ", message)
    )
    
    process := method(input,
        formatted := formatMessage(input)
        logMessage(formatted)
        formatted
    )
)