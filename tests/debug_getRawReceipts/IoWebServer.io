#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(aSocket,
        aSocket streamWrite("HTTP/1.1 200 OK\r\n")
        aSocket streamWrite("Content-Type: text/plain\r\n\r\n")
        aSocket streamWrite("Hello, World!\n")
        aSocket close
    )
)

server := Server clone setPort(8080)
server setHandler(block(aSocket, WebServer handleRequest(aSocket)))
server start
"Server running on port 8080" println
while (true, server accept)