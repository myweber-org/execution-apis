
WebRequest := Object clone do(
    handleSocket := method(socket,
        socket streamWrite("HTTP/1.1 200 OK\r\n")
        socket streamWrite("Content-Type: text/plain\r\n")
        socket streamWrite("\r\n")
        socket streamWrite("Hello, Io!")
        socket close
    )
)

server := Server clone do(
    setPort(8080)
    setSocketHandler(block(socket, WebRequest handleSocket(socket)))
)

"Server starting on port 8080" println
server start
server wait