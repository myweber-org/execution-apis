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
server @handleSocket := server getSlot("handleSocket")
server start(port)
writeln("Server running on port ", port)
server wait