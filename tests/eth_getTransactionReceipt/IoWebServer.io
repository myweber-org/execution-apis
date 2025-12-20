#!/usr/bin/env io

Server := Object clone do(
    port := 8000
    socket := nil
    handlers := Map clone
    
    init := method(
        self socket = Socket clone setPort(port)
        self handlers atPut("GET /", method(request, response,
            response setStatus(200)
            response setHeader("Content-Type", "text/html")
            response write("<html><body><h1>Welcome to Io Server</h1></body></html>")
        ))
    )
    
    handleRequest := method(request,
        method := request method
        path := request path
        key := method .. " " .. path
        
        handler := handlers at(key)
        if(handler isNil,
            Response clone setStatus(404) write("Not Found"),
            handler call(request, Response clone)
        )
    )
    
    start := method(
        "Server starting on port #{port}" interpolate println
        socket serverOpen
        while(true,
            client := socket accept
            requestData := client readBuffer(4096)
            if(requestData,
                request := Request parse(requestData)
                response := handleRequest(request)
                client write(response toString)
            )
            client close
        )
    )
)

Request := Object clone do(
    method := nil
    path := nil
    headers := Map clone
    
    parse := method(data,
        lines := data split("\r\n")
        firstLine := lines at(0) split(" ")
        self method = firstLine at(0)
        self path = firstLine at(1)
        
        lines slice(1) foreach(line,
            if(line size > 0,
                parts := line split(": ")
                if(parts size == 2,
                    headers atPut(parts at(0), parts at(1))
                )
            )
        )
        self
    )
)

Response := Object clone do(
    status := 200
    headers := Map clone
    body := ""
    
    setStatus := method(code, self status = code; self)
    setHeader := method(key, value, headers atPut(key, value); self)
    write := method(data, self body = data; self)
    
    toString := method(
        statusText := if(status == 200, "OK", "Not Found")
        headerLines := headers map(k, v, "#{k}: #{v}" interpolate) join("\r\n")
        "HTTP/1.1 #{status} #{statusText}\r\n#{headerLines}\r\n\r\n#{body}" interpolate
    )
)

if(isLaunchScript,
    server := Server clone
    server port = System args at(1) asNumber ifNonNilEval(8000)
    server init
    server start
)