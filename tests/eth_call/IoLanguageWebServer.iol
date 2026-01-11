#!/usr/local/bin/io

WebRequest := Object clone do(
    handleSocket := method(socket,
        request := socket readLine
        "Received request: #{request}" interpolate println

        response := "HTTP/1.1 200 OK\r\n" ..
                   "Content-Type: text/plain\r\n" ..
                   "Connection: close\r\n\r\n" ..
                   "Hello from Io Language!"

        socket write(response)
        socket close
    )
)

Server := Object clone do(
    port := 8080

    start := method(
        "Starting Io web server on port #{port}" interpolate println
        serverSocket := Socket clone setPort(port)

        serverSocket @handleSocket := method(clientSocket,
            WebRequest clone handleSocket(clientSocket)
        )

        serverSocket start
    )
)

Server start