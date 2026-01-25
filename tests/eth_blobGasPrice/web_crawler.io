
WebCrawler := Object clone do(
    fetchHtml := method(url,
        urlObj := URL with(url)
        urlObj fetch
    )

    extractLinks := method(html,
        links := List clone
        html split("\n") foreach(line,
            if(line containsSeq("href=\""),
                startIndex := line findSeq("href=\"") + 6
                endIndex := line findSeq("\"", startIndex)
                if(endIndex,
                    link := line exSlice(startIndex, endIndex)
                    links append(link)
                )
            )
        )
        links
    )

    crawl := method(startUrl, maxDepth := 2,
        visited := Map clone
        queue := List clone
        queue append(list(startUrl, 1))
        
        while(queue size > 0,
            current := queue removeFirst
            url := current at(0)
            depth := current at(1)
            
            if(visited at(url) not and depth <= maxDepth,
                visited atPut(url, true)
                ("Fetching: " .. url) println
                
                html := self fetchHtml(url)
                if(html,
                    links := self extractLinks(html)
                    ("Found " .. links size .. " links") println
                    
                    links foreach(link,
                        absoluteUrl := URL with(url) resolve(link) asString
                        if(depth < maxDepth,
                            queue append(list(absoluteUrl, depth + 1))
                        )
                    )
                )
            )
        )
        
        visited keys
    )
)

// Example usage
crawler := WebCrawler clone
urls := crawler crawl("http://example.com", 1)
("Total URLs visited: " .. urls size) println
WebCrawler := Object clone do(
    fetchUrl := method(url,
        request := URL with(url) fetch
        if(request isError,
            return "Error fetching URL: #{request error}" interpolate,
            return request contents
        )
    )
    
    extractLinks := method(html,
        links := List clone
        doc := SGML parse(html)
        doc tagsWithName("a") foreach(tag,
            href := tag attributes at("href")
            if(href, links append(href))
        )
        links
    )
)

url := "https://example.com"
html := WebCrawler fetchUrl(url)
links := WebCrawler extractLinks(html)
links foreach(link, link println)