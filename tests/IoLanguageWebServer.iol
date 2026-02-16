
#!/usr/local/bin/io

Server := Object clone do(
    port := 8000
    
    handleRequest := method(socket,
        request := socket readLine
        "Received request: #{request}" interpolate println
        
        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/plain\r\n"
        response = response .. "Connection: close\r\n\r\n"
        response = response .. "Hello, World! from Io Web Server\n"
        
        socket write(response)
        socket close
    )
    
    start := method(
        "Starting Io Web Server on port #{port}" interpolate println
        serverSocket := Socket clone setPort(port)
        serverSocket setReuseAddr(true)
        serverSocket bind
        serverSocket listen
        
        while(true,
            clientSocket := serverSocket accept
            handleRequest(clientSocket) fork
        )
    )
)

Server start