Config := Object clone do(
    port := 8080
    host := "localhost"
    debug := false
    
    loadFromEnv := method(
        if(System getEnvironmentVariable("IO_PORT"),
            port = System getEnvironmentVariable("IO_PORT") asNumber
        )
        if(System getEnvironmentVariable("IO_HOST"),
            host = System getEnvironmentVariable("IO_HOST")
        )
        if(System getEnvironmentVariable("IO_DEBUG"),
            debug = System getEnvironmentVariable("IO_DEBUG") asLowercase == "true"
        )
        self
    )
    
    loadFromFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading
            lines := file readLines
            file close
            
            lines foreach(line,
                if(line contains("="),
                    parts := line split("=")
                    key := parts at(0) strip
                    value := parts at(1) strip
                    
                    if(key == "port", port = value asNumber)
                    if(key == "host", host = value)
                    if(key == "debug", debug = value asLowercase == "true")
                )
            )
        )
        self
    )
    
    validate := method(
        if(port < 1 or port > 65535,
            Exception raise("Invalid port number: #{port}" interpolate)
        )
        self
    )
    
    asString := method(
        "Config(host: #{host}, port: #{port}, debug: #{debug})" interpolate
    )
)

config := Config clone loadFromEnv loadFromFile("server.conf") validate
config println