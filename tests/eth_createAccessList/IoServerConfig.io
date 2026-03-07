
WebServerConfig := Object clone do(
    port := 8080
    host := "127.0.0.1"
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
    
    validate := method(
        if(port < 1 or port > 65535, 
            Exception raise("Invalid port number: #{port}" interpolate)
        )
        if(host asLowercase == "localhost", host = "127.0.0.1")
        self
    )
    
    asString := method(
        "WebServerConfig(host: #{host}, port: #{port}, maxConnections: #{maxConnections})" interpolate
    )
)

config := WebServerConfig clone
config setPort(9090) setHost("0.0.0.0") validate
config asString println