
#!/usr/local/bin/io

Server := Object clone do(
    port ::= 8080
    handlers ::= Map clone
    
    handle := method(path, handler,
        handlers atPut(path, handler)
    )
    
    start := method(
        socket := Socket clone setPort(port)
        socket server
        writeln("Server started on port ", port)
        
        while(true,
            client := socket accept
            request := client readBuffer
            processRequest(client, request)
            client close
        )
    )
    
    processRequest := method(client, request,
        lines := request split("\n")
        if(lines size > 0,
            firstLine := lines at(0)
            parts := firstLine split(" ")
            if(parts size >= 2,
                method := parts at(0)
                path := parts at(1)
                
                handler := handlers at(path)
                if(handler,
                    response := handler call(method, path)
                    client write(response)
                ,
                    client write("HTTP/1.1 404 Not Found\r\n\r\n")
                )
            )
        )
    )
)

// Define request handlers
Server handle("/", block(method, path,
    "HTTP/1.1 200 OK\r\n" ..
    "Content-Type: text/html\r\n\r\n" ..
    "<html><body><h1>Hello from Io Web Server!</h1></body></html>"
))

Server handle("/time", block(method, path,
    "HTTP/1.1 200 OK\r\n" ..
    "Content-Type: text/plain\r\n\r\n" ..
    Date now asString
))

// Start the server
Server start