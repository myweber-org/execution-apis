
URL := "https://example.com"
html := URL fetch asString

startTag := "<title>"
endTag := "</title>"

startIndex := html findSeq(startTag)
if(startIndex,
    endIndex := html findSeq(endTag, startIndex)
    if(endIndex,
        titleStart := startIndex + startTag size
        title := html slice(titleStart, endIndex)
        title println
    )
)
#!/usr/local/bin/io

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
content := Url fetch(url)
content println