#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setHeader("Content-Type", "text/plain")
        response setStatusCode(200)
        response write("Hello from Io HTTP Server!\n")
        response write("Request path: " .. request path .. "\n")
        response write("Time: " .. Date now asString .. "\n")
    )
    
    start := method(port,
        port := port ifNilEval(8080)
        server := Server clone setPort(port)
        server setHandler(block(request, response,
            self handleRequest(request, response)
        ))
        server start
        writeln("HTTP server listening on port ", port)
        server wait
    )
)

if(isLaunchScript,
    HttpServer start(System args at(1) asNumber)
)