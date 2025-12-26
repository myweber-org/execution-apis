#!/usr/bin/env io

WebRequest := Object clone do(
    handleSocket := method(socket,
        request := socket readLine
        "Received request: #{request}" interpolate println
        
        response := "HTTP/1.1 200 OK\r\n" ..
                   "Content-Type: text/plain\r\n" ..
                   "Connection: close\r\n\r\n" ..
                   "Hello from Io Web Server!\n" ..
                   "Current time: #{Date clone now asString}\n" interpolate
        
        socket write(response)
        socket close
    )
)

Server := Object clone do(
    port := 8080
    
    start := method(
        "Starting Io web server on port #{port}" interpolate println
        server := Socket clone setPort(port)
        server setReuseAddr(true)
        server bind
        server listen
        
        while(true,
            socket := server accept
            WebRequest clone asyncSend(handleSocket(socket))
        )
    )
)

if(isLaunchScript,
    Server start
)