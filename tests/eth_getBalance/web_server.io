#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(aSocket,
        request := aSocket readLine
        "Request: #{request}" interpolate println

        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/html\r\n"
        response = response .. "Connection: close\r\n\r\n"
        response = response .. "<html><body><h1>Hello, Io World!</h1></body></html>"

        aSocket write(response)
        aSocket close
    )

    start := method(port,
        server := Server clone setPort(port)
        server ?handleSocket := method(aSocket,
            handleRequest(aSocket)
        )
        "Server starting on port #{port}" interpolate println
        server start
    )
)

if(isLaunchScript,
    WebServer start(8080)
)