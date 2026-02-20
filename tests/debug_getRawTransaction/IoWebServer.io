#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(aSocket,
        request := aSocket readLine
        "Received request: #{request}" interpolate println

        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/plain\r\n"
        response = response .. "Connection: close\r\n\r\n"
        response = response .. "Hello, World! from Io Web Server\n"

        aSocket write(response)
        aSocket close
    )
)

server := Server clone setPort(8080)
server setHandler(block(aSocket, WebServer handleRequest(aSocket)))
"Starting Io web server on port 8080..." println
server start