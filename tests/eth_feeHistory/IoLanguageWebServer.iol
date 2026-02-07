#!/usr/bin/env io

Server := Object clone do(
    port := 8000
    socket := nil
    routes := Map clone
    
    handleRequest := method(request, socket,
        lines := request split("\n")
        if(lines size > 0,
            firstLine := lines at(0)
            parts := firstLine split(" ")
            if(parts size >= 2,
                method := parts at(0)
                path := parts at(1)
                
                handler := routes at(path)
                if(handler,
                    response := handler call(method, path)
                    socket write("HTTP/1.1 200 OK\r\n")
                    socket write("Content-Type: text/html\r\n")
                    socket write("Connection: close\r\n\r\n")
                    socket write(response)
                ,
                    socket write("HTTP/1.1 404 Not Found\r\n")
                    socket write("Content-Type: text/plain\r\n\r\n")
                    socket write("404 - Page not found")
                )
            )
        )
        socket close
    )
    
    get := method(path, handler,
        routes atPut(path, handler)
    )
    
    run := method(
        socket = NetworkService clone setPort(port)
        socket setHandler(block(request, socket, 
            self handleRequest(request, socket)
        ))
        socket start
        "Server running on port #{port}" interpolate println
        self
    )
)

server := Server clone
server get("/", block(method, path, 
    "<html><body><h1>Io Web Server</h1><p>Current time: #{Date clone asString}</p></body></html>" interpolate
))
server get("/about", block(method, path,
    "<html><body><h1>About</h1><p>Simple web server written in Io language</p></body></html>"
))

server run
waitForKey := method(
    "Press Enter to stop server..." println
    stdin readLine
)