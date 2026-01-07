
#!/usr/bin/env io

Url := Object clone do(
    fetch := method(url,
        socket := Socket clone setHost(url host, 80)
        socket connect
        socket write("GET #{url path} HTTP/1.1\r\nHost: #{url host}\r\n\r\n")
        response := socket readBuffer
        socket close
        response
    )
)

url := URL with("http://example.com")
html := Url fetch(url)
html println