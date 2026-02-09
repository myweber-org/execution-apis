#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setStatusCode(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello from Io HTTP Server!")
        response close
    )
    
    start := method(port,
        server := Server clone setPort(port)
        server setHandler(handleRequest)
        server start
        "Server started on port #{port}" interpolate println
        server wait
    )
)

if(isLaunchScript,
    HttpServer start(8080)
)