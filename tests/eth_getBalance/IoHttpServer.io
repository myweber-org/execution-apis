#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        if(request method == "GET",
            response setStatus(200)
            response setHeader("Content-Type", "text/plain")
            response write("Hello, World!")
            response close()
        ,
            response setStatus(405)
            response setHeader("Content-Type", "text/plain")
            response write("Method Not Allowed")
            response close()
        )
    )
)

server := HttpServer clone
server setPort(8080)
server setHandleRequest(block(request, response,
    server handleRequest(request, response)
))

writeln("Server starting on port 8080")
server start
writeln("Press Ctrl+C to stop")

while(true, yield)#!/usr/bin/env io

Server := Object clone do(
    handleRequest := method(request, response,
        if(request method == "GET",
            response setStatus(200)
            response setHeader("Content-Type", "text/plain")
            response write("Hello, World!")
            response close()
        ,
            response setStatus(405)
            response setHeader("Content-Type", "text/plain")
            response write("Method Not Allowed")
            response close()
        )
    )
)

server := Server clone
server setPort(8080)
server handleSocket := method(socket,
    request := socket readRequest
    response := socket createResponse
    handleRequest(request, response)
)

server start
writeln("Server running at http://localhost:8080/")