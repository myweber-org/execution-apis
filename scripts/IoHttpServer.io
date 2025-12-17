
#!/usr/bin/env io

HttpServer := Object clone do(
    handleSocket := method(socket,
        request := socket readLine
        "Received request: #{request}" interpolate println

        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/plain\r\n"
        response = response .. "Connection: close\r\n\r\n"
        response = response .. "Hello, World! from Io\n"

        socket write(response)
        socket close
    )
)

server := Server clone
server setPort(8080)
server setHandler(block(socket, HttpServer handleSocket(socket)))
server start

"HTTP server listening on port 8080" println
server wait