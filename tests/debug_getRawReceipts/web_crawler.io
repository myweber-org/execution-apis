
WebCrawler := Object clone do(
    fetchHtml := method(url,
        urlObj := URL with(url)
        urlObj fetch
    )

    extractLinks := method(html,
        links := List clone
        html asMutable findSeq("href=\"") repeat(
            startPos := html findSeq("href=\"")
            if(startPos isNil, break)
            html := html slice(startPos + 6)
            endPos := html findSeq("\"")
            if(endPos isNil, break)
            link := html slice(0, endPos)
            links append(link)
            html := html slice(endPos + 1)
        )
        links
    )

    crawl := method(startUrl, maxDepth,
        visited := Map clone
        queue := List clone
        queue append(list(startUrl, 0))
        
        while(queue size > 0,
            current := queue removeFirst
            url := current at(0)
            depth := current at(1)
            
            if(visited hasKey(url) not and depth <= maxDepth,
                visited atPut(url, true)
                writeln("Crawling: ", url, " at depth ", depth)
                
                html := fetchHtml(url)
                if(html,
                    links := extractLinks(html)
                    links foreach(link,
                        absoluteUrl := URL with(url) resolve(link)
                        queue append(list(absoluteUrl asString, depth + 1))
                    )
                )
            )
        )
        visited keys
    )
)

// Example usage
crawler := WebCrawler clone
urls := crawler crawl("http://example.com", 2)
urls foreach(url, writeln("Found: ", url))
#!/usr/bin/env io

Url := Object clone do(
    fetch := method(url,
        socket := Socket clone setHost(url host, 80)
        socket connect
        socket write("GET #{url path} HTTP/1.0\r\nHost: #{url host}\r\n\r\n")
        response := socket readBuffer
        socket close
        response
    )
)

HtmlParser := Object clone do(
    extractLinks := method(html,
        links := List clone
        html split("\n") foreach(line,
            if(line containsSeq("href="),
                start := line findSeq("href=") + 6
                end := line findSeq("\"", start)
                if(end, links append(line slice(start, end)))
            )
        )
        links
    )
)

crawler := Object clone do(
    crawl := method(urlString,
        url := URL with(urlString)
        html := Url fetch(url)
        links := HtmlParser extractLinks(html)
        links foreach(link, link println)
    )
)

if(System args size > 0,
    crawler crawl(System args at(0))
)