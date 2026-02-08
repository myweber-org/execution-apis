#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello from Io HTTP Server!")
        response close
    )
    
    start := method(port,
        server := Server clone setPort(port)
        server setHandler(handleRequest)
        server start
        "Server started on port #{port}" interpolate println
        server wait
    )
)

if(isLaunchScript,
    HttpServer start(8080)
)#!/usr/bin/env io

Server := Object clone do(
    handleSocket := method(socket,
        socket streamWrite("HTTP/1.1 200 OK\r\n")
        socket streamWrite("Content-Type: text/plain\r\n")
        socket streamWrite("\r\n")
        socket streamWrite("Hello, World!\n")
        socket close
    )
)

port := 8080
server := Server clone
server setPort(port)
server setHandler(block(socket, server handleSocket(socket)))
server start
writeln("Server running on port ", port)
server wait#!/usr/bin/env io

Server := Object clone do(
    handleSocket := method(socket,
        request := socket readLine
        "Received request: #{request}" interpolate println

        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/plain\r\n"
        response = response .. "Connection: close\r\n\r\n"
        response = response .. "Hello, World! from Io\n"

        socket write(response)
        socket close
    )
)

port := 8080
server := Server clone
server setPort(port)
server setHandler(block(socket, server handleSocket(socket)))
server start
"Server running on port #{port}" interpolate println

while(true, server accept)