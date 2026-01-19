
#!/usr/bin/env io

WebServer := Object clone do(
    port := 8000
    socket := nil
    
    handleRequest := method(request,
        "HTTP/1.1 200 OK\r\n" ..
        "Content-Type: text/html\r\n" ..
        "\r\n" ..
        "<html><body><h1>Hello from Io Web Server!</h1>" ..
        "<p>Request received at: #{Date clone now asString}</p>" ..
        "<p>Request method: #{request split at(0)}</p>" ..
        "</body></html>"
    )
    
    start := method(
        socket := Socket clone setPort(port)
        socket bind listen
        
        "Server listening on port #{port}" println
        
        while(true,
            client := socket accept
            request := client readLine
            if(request,
                response := handleRequest(request)
                client write(response)
            )
            client close
        )
    )
)

server := WebServer clone
server start