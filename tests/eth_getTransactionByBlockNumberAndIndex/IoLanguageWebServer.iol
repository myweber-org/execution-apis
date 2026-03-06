#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(aSocket,
        request := aSocket readBuffer
        aSocket write("HTTP/1.1 200 OK\r\n")
        aSocket write("Content-Type: text/plain\r\n")
        aSocket write("\r\n")
        aSocket write("Hello from the Io web server!")
        aSocket close
    )
)

server := Server clone setPort(8080)
server setHandler(block(aSocket, WebServer handleRequest(aSocket)))
server start
writeln("Server running on port 8080...")
while(true, yield)