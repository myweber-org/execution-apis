#!/usr/bin/env io

Server := Object clone do(
    handleSocket := method(socket,
        socket streamWrite("HTTP/1.1 200 OK\r\n")
        socket streamWrite("Content-Type: text/plain\r\n")
        socket streamWrite("\r\n")
        socket streamWrite("Hello, Io!")
        socket close
    )
)

port := 8080
server := Server clone
server @handleSocket := server getSlot("handleSocket")

serverSocket := Socket clone setPort(port)
serverSocket setReuseAddr(true)
serverSocket bind
serverSocket listen

writeln("Server listening on port ", port)

while(true,
    clientSocket := serverSocket accept
    server handleSocket(clientSocket)
)