#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(aSocket,
        aSocket streamWrite("HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!")
        aSocket close
    )
)

server := Server clone setPort(8080) setSocketOptions(list("reuseAddr", true))
server handleSocket := method(aSocket,
    WebServer clone asyncSend(handleRequest(aSocket))
)

"Server running on port 8080" println
server start
