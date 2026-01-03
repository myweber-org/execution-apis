ServerConfig := Object clone do(
    port := 8080
    host := "localhost"
    
    setPort := method(newPort,
        port = newPort
        self
    )
    
    setHost := method(newHost,
        host = newHost
        self
    )
    
    printConfig := method(
        "Server running on #{host}:#{port}" interpolate println
    )
)

config := ServerConfig clone
config setPort(9000) setHost("0.0.0.0")
config printConfig