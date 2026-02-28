#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello, World!")
        response close
    )
)

server := HttpServer clone
server setPort(8080)
server handleSocket := method(socket,
    socket readRequest
    request := socket getRequest
    response := socket getResponse
    handleRequest(request, response)
)

server start
writeln("Server running at http://localhost:8080/")

while(true, yield)