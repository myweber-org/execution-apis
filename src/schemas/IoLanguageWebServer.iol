
#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello, World!")
        response close
    )
)

server := Server clone setPort(8080) setHandler(WebServer)
server start
"Server running at http://localhost:8080/" println
while(true, server handleRequest)
#!/usr/local/bin/io

Server := Object clone do(
    port := 8000
    socket := nil
    
    handleRequest := method(request, response,
        response write("HTTP/1.1 200 OK\r\n")
        response write("Content-Type: text/html\r\n\r\n")
        response write("<html><body>")
        response write("<h1>Hello from Io Web Server!</h1>")
        response write("<p>Current time: #{Date clone now asString}</p>" interpolate)
        response write("<p>Request received at: #{Date clone now asString}</p>" interpolate)
        response write("</body></html>")
    )
    
    start := method(
        socket := Socket clone setPort(port)
        socket setOption("reuseaddr", true)
        
        socket bind listen
        
        "Server listening on port #{port}" interpolate println
        
        while(true,
            client := socket accept
            request := client readLine
            "Received request: #{request}" interpolate println
            
            handleRequest(request, client)
            client close
        )
    )
)

server := Server clone
server start