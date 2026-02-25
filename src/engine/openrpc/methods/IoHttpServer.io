#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setHeader("Content-Type", "text/plain")
        response setStatusCode(200)
        response write("Hello, World!")
        response close
    )
)

server := HttpServer clone
server setPort(8080)
server handleSocket := method(socket,
    request := socket readRequest
    response := socket createResponse
    handleRequest(request, response)
)

server start
"Server running at http://localhost:8080" println
server wait