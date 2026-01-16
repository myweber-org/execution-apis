#!/usr/bin/env io

Server := Object clone do(
    handleSocket := method(socket,
        socket streamReadNextChunk
        request := socket readBuffer
        // Simple response
        response := "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!"
        socket write(response)
        socket close
    )
)

port := 8080
server := Server clone
server @handleSocket := server getSlot("handleSocket")

"Server starting on port #{port}" interpolate println
Server startListeningOnPort(port)