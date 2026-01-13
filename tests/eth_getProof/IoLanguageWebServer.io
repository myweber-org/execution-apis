
#!/usr/bin/env io

Server := Object clone do(
    handleRequest := method(request, response,
        response write("HTTP/1.1 200 OK\r\n")
        response write("Content-Type: text/plain\r\n")
        response write("\r\n")
        response write("Hello from Io Web Server!\n")
        response write("Requested path: #{request path}\n" interpolate)
        response write("Current time: #{Date clone now asString}\n" interpolate)
    )
    
    start := method(port,
        socket := Socket clone setPort(port) setHost("127.0.0.1")
        socket bind listen
        
        "Server listening on port #{port}" interpolate println
        
        while(true,
            client := socket accept
            request := client readBuffer(4096)
            
            if(request,
                lines := request split("\r\n")
                firstLine := lines at(0)
                if(firstLine,
                    parts := firstLine split(" ")
                    if(parts size >= 2,
                        request := Map clone
                        request atPut("method", parts at(0))
                        request atPut("path", parts at(1))
                        
                        response := Object clone do(
                            buffer := Sequence clone
                            write := method(data, buffer appendSeq(data); self)
                            flush := method(client write(buffer); client close)
                        )
                        
                        handleRequest(request, response)
                        response flush
                    )
                )
            )
        )
    )
)

if(isLaunchScript,
    port := System args at(1) ifNil(8080) asNumber
    Server start(port)
)