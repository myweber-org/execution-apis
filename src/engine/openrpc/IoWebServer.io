#!/usr/bin/env io

Server := Object clone do(
    handleSocket := method(socket,
        socket streamReadNextChunk
        request := socket readBuffer
        // Simple response
        response := "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World from Io!\n"
        socket write(response)
        socket close
    )
)

// Create and start the server on port 8080
server := Server clone
server @port := 8080
server start
writeln("Server running on port 8080...")
server wait