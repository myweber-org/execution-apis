#!/usr/bin/env io

WebServer := Object clone do(
    handleRequest := method(aSocket,
        aSocket streamWrite("HTTP/1.1 200 OK\r\n")
        aSocket streamWrite("Content-Type: text/plain\r\n\r\n")
        aSocket streamWrite("Hello, World!\n")
        aSocket close
    )
)

server := Server clone setPort(8080)
server setHandler(block(aSocket, WebServer handleRequest(aSocket)))
server start
"Server running on port 8080" println
while (true, server accept)#!/usr/local/bin/io

Server := Object clone do(
    port ::= 8080
    socket := nil
    handlers := Map clone
    
    init := method(
        socket = Socket clone setPort(port)
        handlers atPut("default", 
            block(req, res, 
                res status(200) contentType("text/plain") body("Hello from Io Server!")
            )
        )
    )
    
    handle := method(path, handlerBlock,
        handlers atPut(path, handlerBlock)
    )
    
    start := method(
        socket serverOpen
        writeln("Server started on port ", port)
        
        while(socket isOpen,
            client := socket accept
            if(client,
                request := client readRequest
                response := HttpResponse clone
                
                path := request path ?request path : "default"
                handler := handlers at(path)
                if(handler isNil, handler = handlers at("default"))
                
                handler call(request, response)
                client sendResponse(response)
                client close
            )
        )
    )
)

HttpRequest := Object clone do(
    method ::= "GET"
    path ::= "/"
    headers := Map clone
    body ::= ""
    
    parse := method(rawData,
        lines := rawData split("\r\n")
        firstLine := lines at(0) split(" ")
        if(firstLine size >= 2,
            method = firstLine at(0)
            path = firstLine at(1)
        )
        
        lines slice(1) foreach(line,
            if(line contains(":"),
                parts := line split(":", 2)
                headers atPut(parts at(0) strip, parts at(1) strip)
            )
        )
        self
    )
)

HttpResponse := Object clone do(
    statusCode ::= 200
    statusMessage ::= "OK"
    headers := Map clone
    body ::= ""
    
    status := method(code,
        self statusCode = code
        self
    )
    
    contentType := method(type,
        headers atPut("Content-Type", type)
        self
    )
    
    body := method(data,
        self body = data
        headers atPut("Content-Length", data size asString)
        self
    )
    
    asString := method(
        "HTTP/1.1 " .. statusCode .. " " .. statusMessage .. "\r\n" ..
        headers map(k, v, k .. ": " .. v) join("\r\n") ..
        "\r\n\r\n" .. body
    )
)

Socket clone do(
    readRequest := method(
        data := self readBuffer(4096)
        HttpRequest clone parse(data)
    )
    
    sendResponse := method(response,
        self write(response asString)
    )
)

// Example usage
server := Server clone setPort(8080)
server handle("/time", 
    block(req, res,
        res status(200) 
           contentType("text/plain") 
           body(Date now asString)
    )
)

server handle("/echo", 
    block(req, res,
        res status(200)
           contentType("text/plain")
           body("Echo: " .. (req headers at("User-Agent") ?req headers at("User-Agent") : "No UA"))
    )
)

server start