#!/usr/local/bin/io

Server := Object clone do(
    handleRequest := method(aSocket,
        request := aSocket readLine
        "Received request: #{request}" interpolate println

        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/plain\r\n"
        response = response .. "Connection: close\r\n\r\n"
        response = response .. "Hello from Io Language!"

        aSocket write(response)
        aSocket close
    )
)

port := 8080
serverSocket := Socket clone setPort(port) setAddress("0.0.0.0")
serverSocket bind listen

"Server listening on port #{port}" interpolate println

while(true,
    clientSocket := serverSocket accept
    Server handleRequest(clientSocket)
)