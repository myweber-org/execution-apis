
#!/usr/bin/env io

Server := Object clone do(
    handleSocket := method(socket,
        socket streamWrite("HTTP/1.1 200 OK\r\n")
        socket streamWrite("Content-Type: text/plain\r\n\r\n")
        socket streamWrite("Hello from Io Web Server!\n")
        socket close
    )
)

port := 8080
server := Server clone
server @handleSocket
server setPort(port)
server start
writeln("Server running on port ", port, "...")
server wait