#!/usr/bin/env io

WebServer := Object clone do(
    port ::= 8080
    handler ::= nil
    
    handleRequest := method(socket,
        request := socket readLine
        path := request split(" ")[1]
        
        response := if(handler,
            handler call(path)
        ,
            "HTTP/1.1 200 OK\r\n" ..
            "Content-Type: text/plain\r\n" ..
            "\r\n" ..
            "Hello from Io web server! Path: #{path}" interpolate
        )
        
        socket write(response)
        socket close
    )
    
    start := method(
        server := NetworkService clone setPort(port)
        server setHandleSocket(block(socket, handleRequest(socket)))
        
        "Server running on port #{port}" interpolate println
        server start
    )
)

// Example usage with custom handler
server := WebServer clone
server setHandler(block(path,
    "HTTP/1.1 200 OK\r\n" ..
    "Content-Type: text/html\r\n" ..
    "\r\n" ..
    "<html><body><h1>Path requested: #{path}</h1></body></html>" interpolate
))

server start