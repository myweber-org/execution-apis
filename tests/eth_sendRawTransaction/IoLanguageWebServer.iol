#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello from Io Web Server!")
        response close
    )
    
    start := method(port,
        server := Server clone setPort(port)
        server handleSocket := method(socket,
            request := socket readRequest
            response := Response clone setSocket(socket)
            self handleRequest(request, response)
        )
        server start
        "Server started on port #{port}" interpolate println
    )
)

Server := Object clone do(
    setPort := method(port, self port := port; self)
    
    start := method(
        socket := Socket clone setPort(self port) startAccepting
        while(socket isOpen,
            client := socket accept
            if(client, self handleSocket(client))
        )
    )
)

Response := Object clone do(
    setSocket := method(socket, self socket := socket; self)
    
    setStatus := method(code, self status := code; self)
    
    setHeader := method(name, value,
        if(self headers isNil, self headers := Map clone)
        self headers atPut(name, value)
        self
    )
    
    write := method(data,
        if(self headers, self writeHeaders)
        self socket write(data)
    )
    
    writeHeaders := method(
        self socket write("HTTP/1.1 #{self status} OK\r\n" interpolate)
        self headers foreach(name, value,
            self socket write("#{name}: #{value}\r\n" interpolate)
        )
        self socket write("\r\n")
    )
    
    close := method(self socket close)
)

if(isLaunchScript,
    WebServer start(8080)
)