#!/usr/local/bin/io

HttpClient := Object clone do(
    socket := nil
    host := ""
    port := 80
    
    init := method(
        self socket = Socket clone
    )
    
    connect := method(urlString,
        url := URL clone with(urlString)
        self host = url host
        self port = url port ifNilEval(80)
        
        socket setHost(host) setPort(port)
        if(socket connect, 
            return true, 
            return false
        )
    )
    
    sendRequest := method(path, method := "GET", headers := Map clone, body := nil,
        request := method .. " " .. path .. " HTTP/1.1\r\n"
        request = request .. "Host: " .. host .. "\r\n"
        
        headers foreach(key, value,
            request = request .. key .. ": " .. value .. "\r\n"
        )
        
        if(body,
            request = request .. "Content-Length: " .. body size .. "\r\n"
        )
        
        request = request .. "\r\n"
        
        if(body,
            request = request .. body
        )
        
        socket write(request)
    )
    
    readResponse := method(
        response := socket readBuffer
        socket close
        return response
    )
    
    get := method(urlString, path := "/",
        if(connect(urlString),
            sendRequest(path)
            return readResponse(),
            return "Connection failed"
        )
    )
)

// Example usage
client := HttpClient clone
response := client get("http://httpbin.org/get", "/get")
response println