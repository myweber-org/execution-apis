
#!/usr/local/bin/io

Url := Object clone do(
    fetch := method(url,
        url := if(url asLower beginsWithSeq("http"), url, "http://" .. url)
        page := URL with(url) fetch
        if(page,
            titleRegex := Regex with("<title>(.*?)</title>")
            match := titleRegex matches(page)
            if(match, match at(1) strip, "No title found")
        ,
            "Failed to fetch page"
        )
    )
)

if(System args size > 1,
    url := System args at(1)
    title := Url fetch(url)
    title println
,
    "Usage: web_crawler.io <url>" println
)
WebCrawler := Object clone do(
    fetchUrl := method(url,
        urlObj := URL with(url)
        urlObj fetch
    )

    extractLinks := method(html,
        links := List clone
        html split("\n") foreach(line,
            if(line containsSeq("href=\""),
                start := line findSeq("href=\"") + 6
                end := line findSeq("\"", start)
                if(end != nil,
                    link := line slice(start, end)
                    if(link beginsWithSeq("http"),
                        links append(link)
                    )
                )
            )
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
                
                html := fetchUrl(url)
                if(html != nil,
                    links := extractLinks(html)
                    links foreach(link,
                        queue append(list(link, depth + 1))
                    )
                )
            )
        )
        writeln("Crawling completed. Visited ", visited size, " pages.")
    )
)

// Example usage
crawler := WebCrawler clone
crawler crawl("http://example.com", 2)