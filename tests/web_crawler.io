
WebCrawler := Object clone do(
    fetchHtml := method(url,
        url asURL fetch
    )

    parseLinks := method(html,
        links := List clone
        html findallSeq("href=\"(.*?)\"") foreach(match,
            links append(match at(1))
        )
        links
    )

    crawl := method(startUrl, maxDepth,
        visited := Map clone
        queue := list(list(startUrl, 0))
        
        while(queue size > 0,
            current := queue removeFirst
            url := current at(0)
            depth := current at(1)
            
            if(visited hasKey(url) not and depth <= maxDepth,
                visited atPut(url, true)
                writeln("Crawling: ", url, " at depth ", depth)
                
                html := self fetchHtml(url)
                if(html,
                    links := self parseLinks(html)
                    links foreach(link,
                        absoluteUrl := if(link beginsWithSeq("http"),
                            link,
                            URL with(url) setPath(link) asString
                        )
                        queue append(list(absoluteUrl, depth + 1))
                    )
                )
            )
        )
        visited keys
    )
)

// Example usage
crawler := WebCrawler clone
urls := crawler crawl("https://example.com", 2)
urls join("\n") println