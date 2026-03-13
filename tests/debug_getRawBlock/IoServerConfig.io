WebServerConfig := Object clone do(
    port ::= 8080
    host ::= "localhost"
    maxConnections ::= 100
    enableSSL := false
    sslCertPath ::= ""
    sslKeyPath ::= ""
    
    loadFromFile := method(path,
        configMap := doFile(path)
        if(configMap isNil, 
            Exception raise("Failed to load config from: " .. path)
        )
        
        self port = configMap at("port") ifNonNilEval(port)
        self host = configMap at("host") ifNonNilEval(host)
        self maxConnections = configMap at("maxConnections") ifNonNilEval(maxConnections)
        self enableSSL = configMap at("enableSSL") ifNonNilEval(enableSSL)
        self sslCertPath = configMap at("sslCertPath") ifNonNilEval(sslCertPath)
        self sslKeyPath = configMap at("sslKeyPath") ifNonNilEval(sslKeyPath)
        
        self validate
        self
    )
    
    validate := method(
        if(port < 1 or port > 65535,
            Exception raise("Invalid port number: " .. port asString)
        )
        
        if(maxConnections < 1,
            Exception raise("maxConnections must be positive")
        )
        
        if(enableSSL,
            if(sslCertPath isEmpty,
                Exception raise("SSL certificate path required when SSL enabled")
            )
            if(sslKeyPath isEmpty,
                Exception raise("SSL key path required when SSL enabled")
            )
        )
    )
    
    asString := method(
        "WebServerConfig(host: #{host}, port: #{port}, maxConnections: #{maxConnections})" interpolate
    )
)

// Example usage
config := WebServerConfig clone loadFromFile("server_config.io")
writeln("Loaded config: ", config)