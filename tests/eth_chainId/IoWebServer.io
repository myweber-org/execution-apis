#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(request, response,
        response setHeader("Content-Type", "text/plain")
        response write("Hello from Io Web Server!")
        response close()
    )
)

server := Server clone do(
    setPort(8080)
    handleSocket := method(socket,
        request := socket readBuffer
        response := Response clone
        WebServer handleRequest(request, response)
        socket write(response asString)
        socket close()
    )
)

server start
"Web server running on port 8080" println