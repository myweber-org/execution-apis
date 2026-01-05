#!/usr/bin/env io

Server := Object clone do(
    handleSocket := method(socket,
        socket streamWrite("HTTP/1.1 200 OK\r\n")
        socket streamWrite("Content-Type: text/plain\r\n")
        socket streamWrite("\r\n")
        socket streamWrite("Hello, World!\n")
        socket close
    )
)

port := 8080
server := Server clone
server setPort(port)
server handleSocket := method(socket,
    Server handleSocket(socket)
)
server start
writeln("Server running on port ", port)
server wait#!/usr/bin/env io

Server := Object clone do(
    handleSocket := method(socket,
        socket streamReadNextChunk
        request := socket readBuffer
        response := "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!"
        socket write(response)
        socket close
    )
)

server := Server clone
server start(8000)
"Server running on port 8000" println
server wait