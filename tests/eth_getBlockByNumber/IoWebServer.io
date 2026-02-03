
#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(aSocket,
        aSocket streamWrite("HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, Io!")
        aSocket close
    )
)

server := Server clone setPort(8080)
server setHandler(block(aSocket, WebServer handleRequest(aSocket)))
server start
"Web server running on port 8080" println
while(true, server handleRequest wait(1))