
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