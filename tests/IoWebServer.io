#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(request, response,
        response setHeader("Content-Type", "text/plain")
        response setStatusCode(200)
        response write("Hello from Io Web Server!")
        response close
    )
)

server := Server clone do(
    setPort(8080)
    setHost("127.0.0.1")
    handleSocket := method(socket,
        request := socket readRequest
        response := Response clone setSocket(socket)
        WebServer handleRequest(request, response)
    )
)

"Starting Io web server on http://127.0.0.1:8080" println
server start
"Server running. Press Ctrl+C to stop." println

while (server isRunning,
    yield
)