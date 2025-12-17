#!/usr/bin/env io

Server := Object clone do(
    handleSocket := method(socket,
        socket readLine // Read request line (ignored for simplicity)
        while(socket readLine != "", nil) // Read headers until empty line

        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/plain\r\n"
        response = response .. "Connection: close\r\n"
        response = response .. "\r\n"
        response = response .. "Hello, World!"

        socket write(response)
        socket close
    )
)

port := 8080
serverSocket := Socket clone setPort(port) setReuseAddr(true)
serverSocket bind listen

writeln("Server listening on port ", port)

while(true,
    socket := serverSocket accept
    Server handleSocket(socket) fork // Handle each connection in a new coroutine
)