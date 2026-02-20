#!/usr/bin/env io

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
    aSocket stream readBuffer := Sequence clone
    request := aSocket stream readLine
    if(request,
        headers := Map clone
        while(headerLine := aSocket stream readLine,
            if(headerLine size == 0, break)
            headerParts := headerLine split(":", 2)
            if(headerParts size == 2,
                headers atPut(headerParts first strip, headerParts last strip)
            )
        )
        response := Object clone do(
            status := 200
            headers := Map clone
            body := Sequence clone
            setStatus := method(code, status = code; self)
            setHeader := method(key, value, headers atPut(key, value); self)
            write := method(data, body appendSeq(data); self)
            close := method(
                aSocket stream write("HTTP/1.1 #{status} OK\r\n" interpolate)
                headers foreach(key, value,
                    aSocket stream write("#{key}: #{value}\r\n" interpolate)
                )
                aSocket stream write("\r\n")
                aSocket stream write(body)
                aSocket close
            )
        )
        handleRequest(request, response)
    )
)

server start
"Server running on port 8080" println
server wait