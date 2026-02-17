#!/usr/bin/env io

WebRequest := Object clone do(
    handleSocket := method(aSocket,
        aSocket streamReadNextChunk
        request := aSocket readBuffer
        ("Received request: " .. request) println

        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/html\r\n"
        response = response .. "Connection: close\r\n\r\n"
        response = response .. "<html><body><h1>Hello, Io World!</h1></body></html>"

        aSocket write(response)
        aSocket close
    )
)

server := Server clone
server setPort(8080)
server handleSocket := method(aSocket,
    WebRequest clone @handleSocket(aSocket)
)

"Server starting on port 8080..." println
server start