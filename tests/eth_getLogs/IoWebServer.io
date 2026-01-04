
#!/usr/bin/env io

Server := Object clone do(
    handleRequest := method(request, response,
        response write("HTTP/1.1 200 OK\r\n")
        response write("Content-Type: text/plain\r\n")
        response write("\r\n")
        response write("Hello from Io Web Server!\n")
        response write("Request path: #{request path}\n" interpolate)
        response write("Time: #{Date now asString}\n" interpolate)
    )
    
    start := method(port,
        socket := Socket clone setPort(port)
        socket bind listen
        
        writeln("Server listening on port #{port}" interpolate)
        
        while(true,
            client := socket accept
            request := client readBuffer
            requestLines := request split("\r\n")
            
            if(requestLines size > 0,
                firstLine := requestLines at(0) split(" ")
                if(firstLine size >= 2,
                    path := firstLine at(1)
                    request := Map clone atPut("path", path)
                    
                    handleRequest(request, client)
                )
            )
            
            client close
        )
    )
)

if(isLaunchScript,
    Server start(8080)
)