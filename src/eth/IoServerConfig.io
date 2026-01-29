
WebServerConfig := Object clone do(
    port := 8080
    host := "localhost"
    maxConnections := 100
    enableLogging := true
    
    setPort := method(newPort,
        port = newPort
        self
    )
    
    setHost := method(newHost,
        host = newHost
        self
    )
    
    displayConfig := method(
        "Server Configuration:" println
        ("Port: " .. port) println
        ("Host: " .. host) println
        ("Max Connections: " .. maxConnections) println
        ("Logging Enabled: " .. enableLogging) println
    )
    
    validateConfig := method(
        if(port < 1 or port > 65535, 
            Exception raise("Invalid port number: " .. port)
        )
        if(maxConnections < 1,
            Exception raise("Max connections must be positive")
        )
        true
    )
)

config := WebServerConfig clone
config setPort(9090) setHost("0.0.0.0")
config displayConfig

try(
    config validateConfig
    "Configuration is valid" println
) catch(Exception,
    ("Configuration error: " .. error) println
)