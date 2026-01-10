
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
)#!/usr/bin/env io

HttpServer := Object clone do(
    handleRequest := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello, World!")
        response close
    )
)

server := HttpServer clone
server setPort(8080)
server handleSocket := method(aSocket,
    aSocket streamReadNextChunk
    request := aSocket readBuffer
    response := Map clone
    self handleRequest(request, response)
    aSocket write("HTTP/1.1 " .. (response at("status") ?response at("status") :200) .. " OK\r\n")
    response foreach(key, value,
        aSocket write(key .. ": " .. value .. "\r\n")
    )
    aSocket write("\r\n")
    aSocket write(response at("body") ?response at("body") :"")
    aSocket close
)

server start
"Server running at http://localhost:8080/" println
server wait