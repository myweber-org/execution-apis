#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello, World!")
        response close
    )
)

server := HttpServer clone
server setPort(8080)
server handleSocket := method(socket,
    socket readRequest
    request := socket getRequest
    response := socket getResponse
    handleRequest(request, response)
)

server start
writeln("Server running at http://localhost:8080/")

while(true, yield)#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setHeader("Content-Type", "text/plain")
        response setStatusCode(200)
        response write("Hello from Io HTTP Server!\n")
        response write("Request path: " .. request path .. "\n")
        response write("Current time: " .. Date now asString .. "\n")
        response close
    )
    
    start := method(port,
        socket := Socket clone setPort(port)
        socket setOption("reuseaddr", true)
        
        socket onAccept := method(clientSocket,
            request := clientSocket readBuffer(4096)
            
            # Simple request parsing
            firstLine := request split("\n") first
            method := firstLine split(" ") at(0)
            path := firstLine split(" ") at(1)
            
            # Create request/response objects
            req := Object clone do(
                method := method
                path := path
                raw := request
            )
            
            resp := Object clone do(
                headers := Map clone
                statusCode := 200
                statusMessage := "OK"
                
                setHeader := method(key, value,
                    headers atPut(key, value)
                )
                
                write := method(data,
                    clientSocket write(data)
                )
                
                close := method(
                    clientSocket close
                )
                
                sendHeaders := method(
                    clientSocket write("HTTP/1.1 " .. statusCode .. " " .. statusMessage .. "\r\n")
                    headers foreach(key, value,
                        clientSocket write(key .. ": " .. value .. "\r\n")
                    )
                    clientSocket write("\r\n")
                )
                
                setStatusCode := method(code,
                    statusCode = code
                    statusMessage = if(code == 200, "OK", 
                                     code == 404, "Not Found",
                                     code == 500, "Internal Server Error",
                                     "Unknown")
                )
            )
            
            # Handle the request
            handleRequest(req, resp)
            
            # Send headers if not already sent
            if(resp headers size == 0,
                resp sendHeaders
            )
        )
        
        socket @open
        socket listen
        
        writeln("HTTP server listening on port ", port)
        writeln("Press Ctrl+C to stop")
        
        # Keep server running
        while(true, yield)
    )
)

# Start server on port 8080 if run directly
if(System args size > 0 and System args first == "run",
    HttpServer start(8080)
)