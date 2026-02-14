Server := Object clone do(
    port := 8080
    handler := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello from Io server")
        response close
    )
    
    start := method(
        "Server starting on port #{port}" interpolate println
        NetworkService startServer("0.0.0.0", port, handler)
    )
)

if(isLaunchScript,
    Server start
    "Press Enter to stop server" println
    File standardInput readLine
    "Server stopped" println
)
IoServerConfig := Object clone do(
    port := 8080
    host := "127.0.0.1"
    maxConnections := 100
    timeout := 30
    
    setPort := method(p, port = p; self)
    setHost := method(h, host = h; self)
    setMaxConnections := method(m, maxConnections = m; self)
    setTimeout := method(t, timeout = t; self)
    
    validate := method(
        if(port < 1 or port > 65535, 
            Exception raise("Invalid port number: " .. port)
        )
        if(maxConnections < 1,
            Exception raise("Invalid max connections: " .. maxConnections)
        )
        if(timeout < 1,
            Exception raise("Invalid timeout: " .. timeout)
        )
        true
    )
    
    asString := method(
        "IoServerConfig(host: #{host}, port: #{port}, maxConnections: #{maxConnections}, timeout: #{timeout})" interpolate
    )
)

defaultConfig := IoServerConfig clone
customConfig := IoServerConfig clone setPort(9090) setHost("0.0.0.0") setMaxConnections(200)

defaultConfig validate
customConfig validate

writeln("Default config: ", defaultConfig)
writeln("Custom config: ", customConfig)