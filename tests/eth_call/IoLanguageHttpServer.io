#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setHeader("Content-Type", "text/plain")
        response setStatusCode(200)
        response write("Hello from Io HTTP Server!")
        response write("\nCurrent time: " .. Date now asString)
        response write("\nRequest path: " .. request path)
        response close
    )
    
    start := method(port,
        server := Server clone setPort(port)
        server setHandler(block(request, response,
            self handleRequest(request, response)
        ))
        
        "Server starting on port #{port}" interpolate println
        server start
    )
)

if(isLaunchScript,
    server := HttpServer clone
    server start(8080)
)