
URL := "https://example.com"
html := URL fetch
parsed := html parseHTML

parsed findElements("h1") foreach(element,
    element text println
)
WebCrawler := Object clone do(
    fetchUrl := method(url,
        request := URL with(url) fetch
        if(request isError,
            Exception raise("Failed to fetch URL: #{url}" interpolate),
            request content
        )
    )
    
    extractLinks := method(html,
        links := List clone
        html split("\n") foreach(line,
            if(line containsSeq("href="),
                start := line findSeq("href=") + 6
                end := line findSeq("\"", start)
                if(end != nil,
                    link := line slice(start, end - 1)
                    links append(link)
                )
            )
        )
        links
    )
    
    crawl := method(startUrl, maxDepth := 2,
        visited := Map clone
        toVisit := list(list(startUrl, 1))
        
        while(toVisit size > 0,
            current := toVisit removeFirst
            url := current at(0)
            depth := current at(1)
            
            if(visited hasKey(url) not,
                visited atPut(url, true)
                writeln("Crawling: ", url, " (depth: ", depth, ")")
                
                try(
                    html := fetchUrl(url)
                    links := extractLinks(html)
                    
                    if(depth < maxDepth,
                        links foreach(link,
                            absoluteUrl := if(link beginsWithSeq("http"),
                                link,
                                URL with(url) asString removeSuffix("/") .. "/" .. link
                            )
                            toVisit append(list(absoluteUrl, depth + 1))
                        )
                    )
                ) catch(Exception,
                    writeln("Error crawling ", url, ": ", error)
                )
            )
        )
        
        writeln("\nCrawling completed. Visited ", visited size, " pages.")
    )
)

// Example usage
if(isLaunchScript,
    crawler := WebCrawler clone
    crawler crawl("https://example.com", 1)
)