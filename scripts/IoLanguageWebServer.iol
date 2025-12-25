#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(aSocket,
        request := aSocket readBuffer
        ("Received request: " .. request) println

        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/plain\r\n"
        response = response .. "Connection: close\r\n\r\n"
        response = response .. "Hello from Io Language!"

        aSocket write(response)
        aSocket close
    )

    start := method(port,
        server := Socket clone setPort(port) setAddress("0.0.0.0")
        server bind listen

        "Server listening on port #{port}" interpolate println

        while(true,
            client := server accept
            handleRequest asyncSend(client)
        )
    )
)

// Start the server on port 8080
WebServer start(8080)