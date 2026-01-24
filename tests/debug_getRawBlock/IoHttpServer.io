
#!/usr/bin/env io

HttpServer := Object clone do(
    handleSocket := method(socket,
        request := socket readLine
        socket write("HTTP/1.1 200 OK\r\n")
        socket write("Content-Type: text/plain\r\n\r\n")
        socket write("Hello, World!\n")
        socket close
    )
)

server := HttpServer clone
server start(8080)
writeln("Server running on port 8080")
server wait