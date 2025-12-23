#!/usr/bin/env io

HttpServer := Object clone do(
    handleSocket := method(socket,
        socket streamWrite("HTTP/1.1 200 OK\r\n")
        socket streamWrite("Content-Type: text/plain\r\n")
        socket streamWrite("\r\n")
        socket streamWrite("Hello, World!\n")
        socket close
    )
)

server := HttpServer clone
server setPort(8080)
server start
server wait