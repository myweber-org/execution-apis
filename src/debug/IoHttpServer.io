
#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setHeader("Content-Type", "text/plain")
        response setStatusCode(200)
        response write("Hello from Io HTTP Server!\n")
        response write("Request path: " .. request path .. "\n")
        response write("Current time: " .. Date now asString .. "\n")
        response close
    )
    
    start := method(port,
        server := NetworkServer clone setPort(port) setHandler(block(request, response,
            self handleRequest(request, response)
        ))
        
        "Starting HTTP server on port #{port}" interpolate println
        server start
        server wait
    )
)

if(isLaunchScript,
    HttpServer start(8080)
)