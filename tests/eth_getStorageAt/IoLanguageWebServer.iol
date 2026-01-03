#!/usr/bin/env io

Server := Object clone do(
    handleSocket := method(socket,
        socket readBuffer := socket readBuffer .. socket read
        if(socket readBuffer containsSeq("\r\n\r\n"),
            request := socket readBuffer beforeSeq("\r\n\r\n")
            response := "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!"
            socket write(response)
            socket close
        )
    )
)

server := Server clone
server @handleSocket := method(socket,
    handleSocket(socket)
)

serverPort := 8080
serverSocket := Socket clone setPort(serverPort)
serverSocket setOption("reuseaddr", true)
serverSocket bind listen

writeln("Server listening on port ", serverPort)

while(true,
    clientSocket := serverSocket accept
    server @handleSocket asyncSend(clientSocket)
)