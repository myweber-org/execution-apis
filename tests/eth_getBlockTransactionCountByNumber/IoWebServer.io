#!/usr/bin/env io

Server := Object clone do(
    handleRequest := method(socket,
        request := socket readLine
        "Received request: #{request}" interpolate println
        
        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/plain\r\n"
        response = response .. "Connection: close\r\n\r\n"
        response = response .. "Hello from Io Web Server!\n"
        response = response .. "Current time: #{Date now asString}\n" interpolate
        
        socket write(response)
        socket close
    )
    
    start := method(port,
        "Starting Io web server on port #{port}" interpolate println
        server := Socket clone setPort(port) setAddress("0.0.0.0")
        server bind listen
        
        while(true,
            client := server accept
            handleRequest(client)
        )
    )
)

if(isLaunchScript,
    port := System args at(1) ifNil(8080)
    Server start(port)
)