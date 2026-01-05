
#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello, World from Io!")
        response close
    )
    
    start := method(port,
        server := Server clone setPort(port) setHandler(block(request, response,
            self handleRequest(request, response)
        ))
        server start
        writeln("HTTP server running on port ", port)
        server wait
    )
)

if(isLaunchScript,
    HttpServer start(8080)
)