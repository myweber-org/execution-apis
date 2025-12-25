#!/usr/bin/env io

HttpServer := Object clone do(
    handleSocket := method(socket,
        socket streamReadNextChunk
        request := socket readBuffer
        response := "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!"
        socket write(response)
        socket close
    )
)

server := HttpServer clone
server setPort(8080)
server handleSocket := method(socket,
    self handleSocket(socket)
)
server start
writeln("Server running at http://localhost:8080/")
server wait