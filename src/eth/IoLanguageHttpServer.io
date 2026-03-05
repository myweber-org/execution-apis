
#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setHeader("Content-Type", "text/plain")
        response setStatusCode(200)
        response write("Hello from Io HTTP Server!")
        response write("\nCurrent time: " .. Date now asString)
        response write("\nRequest path: " .. request path)
        response write("\nServer info: Io/" .. System version)
        response close
    )
    
    start := method(port,
        server := Server clone setPort(port)
        server setHandler(block(request, response,
            self handleRequest(request, response)
        ))
        
        "Starting HTTP server on port #{port}" interpolate println
        "Press Ctrl+C to stop" println
        
        server start
        server wait
    )
)

if(isLaunchScript,
    port := System args at(1) asNumber ifNilEval(8080)
    HttpServer start(port)
)