#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello from Io HTTP Server!")
        response close
    )
    
    start := method(port,
        server := Server clone setPort(port) setHandler(handleRequest)
        server start
        writeln("HTTP server listening on port ", port)
        server wait
    )
)

if(isLaunchScript,
    HttpServer start(8080)
)