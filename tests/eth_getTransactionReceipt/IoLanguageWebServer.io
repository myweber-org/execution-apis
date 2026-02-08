#!/usr/bin/env io

WebServer := Object clone do(
    port := 8000
    host := "127.0.0.1"
    
    handleRequest := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/html")
        response write("<html><body>")
        response write("<h1>Hello from Io Web Server!</h1>")
        response write("<p>Current time: #{Date now asString}</p>" interpolate)
        response write("<p>Request path: #{request path}</p>" interpolate)
        response write("</body></html>")
        response close
    )
    
    start := method(
        server := Server clone setPort(port) setHost(host)
        server setHandleRequest(block(request, response,
            self handleRequest(request, response)
        ))
        
        "Starting web server on #{host}:#{port}" interpolate println
        server start
    )
)

if(isLaunchScript,
    WebServer start
)