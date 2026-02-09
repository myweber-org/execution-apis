
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