
IoMessageLogger := Object clone do(
    logLevels := list("DEBUG", "INFO", "WARN", "ERROR")
    
    init := method(
        self.logFile := nil
        self.minLevel := "INFO"
    )
    
    setLogFile := method(path,
        self.logFile = File with(path) openForAppending
    )
    
    setMinLevel := method(level,
        if(logLevels contains(level),
            self.minLevel = level,
            Exception raise("Invalid log level: #{level}" interpolate)
        )
    )
    
    shouldLog := method(level,
        logLevels indexOf(level) >= logLevels indexOf(self.minLevel)
    )
    
    log := method(level, message,
        if(shouldLog(level),
            timestamp := Date now asString("%Y-%m-%d %H:%M:%S")
            logEntry := "[#{timestamp}] #{level}: #{message}" interpolate
            
            if(self logFile,
                self.logFile write(logEntry, "\n")
                self.logFile flush
            ,
                logEntry println
            )
        )
    )
    
    debug := method(message, log("DEBUG", message))
    info := method(message, log("INFO", message))
    warn := method(message, log("WARN", message))
    error := method(message, log("ERROR", message))
    
    close := method(
        if(self logFile,
            self.logFile close
            self.logFile = nil
        )
    )
)

logger := IoMessageLogger clone
logger setMinLevel("DEBUG")
logger info("Application started")
logger debug("Initializing components")
logger warn("Deprecated API called")
logger error("Failed to connect to database")
logger close