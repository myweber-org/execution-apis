#!/usr/bin/env io

Server := Object clone do(
    port := 8000
    htmlContent := "<!DOCTYPE html><html><head><title>Io Web Server</title></head><body><h1>Hello from Io!</h1><p>This page is served by a simple Io web server.</p></body></html>"
    
    handleRequest := method(socket,
        request := socket readLine
        "Received request: #{request}" interpolate println
        
        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/html\r\n"
        response = response .. "Connection: close\r\n\r\n"
        response = response .. htmlContent
        
        socket write(response)
        socket close
    )
    
    start := method(
        "Starting Io web server on port #{port}" interpolate println
        serverSocket := Socket clone setPort(port)
        serverSocket setReuseAddr(true)
        serverSocket bind
        serverSocket listen
        
        while(true,
            clientSocket := serverSocket accept
            handleRequest(clientSocket)
        )
    )
)

if(isLaunchScript,
    Server start
)