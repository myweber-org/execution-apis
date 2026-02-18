IoMessageLogger := Object clone do(
    logLevel := "INFO"
    
    setLogLevel := method(level,
        self logLevel = level
        self
    )
    
    log := method(level, message,
        if(level == "DEBUG" and logLevel != "DEBUG", return self)
        if(level == "INFO" and logLevel == "ERROR", return self)
        
        timestamp := Date clone now asString("%Y-%m-%d %H:%M:%S")
        writeln("[", timestamp, "] [", level, "] ", message)
        self
    )
    
    debug := method(message, log("DEBUG", message))
    info := method(message, log("INFO", message))
    error := method(message, log("ERROR", message))
    
    filterMessages := method(messages, pattern,
        messages select(message, message contains(pattern))
    )
)

logger := IoMessageLogger clone
logger setLogLevel("DEBUG")

logger info("Application started")
logger debug("Initializing components")

testMessages := list("Io is fun", "Learn Io programming", "Message passing", "Prototype based")
filtered := logger filterMessages(testMessages, "Io")
logger info("Filtered messages: ", filtered)

logger error("Simulated error occurred")
logger info("Application finished")