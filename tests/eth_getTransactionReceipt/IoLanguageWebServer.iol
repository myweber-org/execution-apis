#!/usr/local/bin/io

WebServer := Object clone do(
    port := 8000
    socket := nil
    
    handleRequest := method(request, response,
        response write("HTTP/1.1 200 OK\r\n")
        response write("Content-Type: text/html\r\n")
        response write("\r\n")
        response write("<html><body>")
        response write("<h1>Hello from Io Web Server!</h1>")
        response write("<p>Current time: " .. Date now asString .. "</p>")
        response write("</body></html>")
    )
    
    start := method(
        socket := Socket clone setPort(port)
        socket bind
        socket listen
        
        "Server listening on port #{port}" interpolate println
        
        while(true,
            client := socket accept
            request := client readBuffer(4096)
            
            if(request,
                "Received request:" println
                request println
                
                response := Socket clone
                handleRequest(request, response)
                response writeTo(client)
            )
            
            client close
        )
    )
)

server := WebServer clone
server port = 8080
server start