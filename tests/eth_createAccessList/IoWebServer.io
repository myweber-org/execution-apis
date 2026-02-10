#!/usr/bin/env io

Server := Object clone do(
    port ::= 8080
    routes := Map clone
    
    handleRequest := method(request, response,
        path := request at("path")
        handler := routes at(path)
        
        if(handler,
            handler call(request, response)
        ,
            response setStatus(404)
            response setHeader("Content-Type", "text/plain")
            response write("404 Not Found")
        )
    )
    
    get := method(path, handler,
        routes atPut(path, handler)
    )
    
    start := method(
        socket := Socket clone setPort(port)
        socket startAccepting(
            block(clientSocket,
                request := clientSocket readRequest
                response := Map clone
                handleRequest(request, response)
                
                status := response at("status", 200)
                headers := response at("headers", Map clone)
                body := response at("body", "")
                
                clientSocket write("HTTP/1.1 #{status} OK\r\n" interpolate)
                headers foreach(key, value,
                    clientSocket write("#{key}: #{value}\r\n" interpolate)
                )
                clientSocket write("\r\n")
                clientSocket write(body)
                clientSocket close
            )
        )
        writeln("Server running on port #{port}" interpolate)
    )
)

// Example usage
server := Server clone
server port = 8080

server get("/", block(request, response,
    response atPut("headers", Map clone atPut("Content-Type", "text/html"))
    response atPut("body", "<h1>Welcome to Io Web Server</h1>")
))

server get("/time", block(request, response,
    response atPut("headers", Map clone atPut("Content-Type", "text/plain"))
    response atPut("body", Date now asString)
))

server start