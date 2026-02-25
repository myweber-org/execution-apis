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
server handleSocket := method(aSocket,
    aSocket streamReadNextChunk
    request := aSocket readBuffer
    response := aSocket
    handleRequest(request, response)
)

server start
"Server running at http://localhost:8080" println
wait