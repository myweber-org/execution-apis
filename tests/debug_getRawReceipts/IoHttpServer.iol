
#!/usr/bin/env io

Server := Object clone do(
    handleSocket := method(socket,
        socket streamReadNextChunk
        request := socket readBuffer
        "Received request:" println
        request println

        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/plain\r\n"
        response = response .. "Connection: close\r\n\r\n"
        response = response .. "Hello, Io!"

        socket write(response)
        socket close
    )
)

port := 8080
server := Server clone
server setPort(port)
server setHandler(block(socket, server handleSocket(socket)))
server start
"Server running on port #{port}" interpolate println

while(true, yield)