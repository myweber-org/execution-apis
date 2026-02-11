
Server := Object clone do(
    port := 8080
    handler := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello from Io server")
        response close
    )
    
    start := method(
        "Server starting on port #{port}" interpolate println
        NetworkService startServer(port, handler)
    )
)

if(isLaunchScript,
    Server start
)
Server := Object clone do(
    port := 8080
    host := "127.0.0.1"
    
    handleRequest := method(socket,
        request := socket readLine
        path := request split(" ")[1]
        
        response := "HTTP/1.1 200 OK\r\n"
        response = response .. "Content-Type: text/plain\r\n\r\n"
        response = response .. "Hello from Io server! Path: #{path}" interpolate
        
        socket write(response)
        socket close
    )
    
    start := method(
        serverSocket := Socket clone setHost(host) setPort(port)
        serverSocket bind listen
        
        "Server listening on #{host}:#{port}" interpolate println
        
        while(true,
            clientSocket := serverSocket accept
            handleRequest(clientSocket)
        )
    )
)

if(isLaunchScript,
    Server start
)