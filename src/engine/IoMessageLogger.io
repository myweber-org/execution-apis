
MessageLogger := Object clone do(
    logLevel := "INFO"
    validLevels := list("DEBUG", "INFO", "WARN", "ERROR", "FATAL")
    
    setLogLevel := method(level,
        if(validLevels contains(level),
            logLevel = level
        ,
            Exception raise("Invalid log level: " .. level)
        )
    )
    
    shouldLog := method(level,
        validLevels indexOf(level) >= validLevels indexOf(logLevel)
    )
    
    log := method(level, message,
        if(shouldLog(level),
            currentTime := Date clone now asString("%Y-%m-%d %H:%M:%S")
            formattedMessage := "[#{currentTime}] [#{level}] #{message}" interpolate
            formattedMessage println
        )
    )
    
    debug := method(message, log("DEBUG", message))
    info := method(message, log("INFO", message))
    warn := method(message, log("WARN", message))
    error := method(message, log("ERROR", message))
    fatal := method(message, log("FATAL", message))
    
    filterMessages := method(messages, minLevel,
        messages select(message,
            validLevels indexOf(message at("level")) >= validLevels indexOf(minLevel)
        )
    )
)

logger := MessageLogger clone
logger setLogLevel("INFO")

logger debug("This debug message won't appear")
logger info("Application started successfully")
logger warn("Disk space is running low")
logger error("Failed to connect to database")

testMessages := list(
    Map clone atPut("level", "DEBUG") atPut("content", "Debug message 1"),
    Map clone atPut("level", "INFO") atPut("content", "Info message 1"),
    Map clone atPut("level", "ERROR") atPut("content", "Error message 1")
)

filtered := logger filterMessages(testMessages, "INFO")
filtered foreach(msg, "Filtered: #{msg at("content")}" interpolate println)