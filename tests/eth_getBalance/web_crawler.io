
URL := "https://example.com"
html := URL fetch asString
"Fetched #{html size} bytes from #{URL}" println

if(html contains("Example Domain"),
    "Found 'Example Domain' in the response" println,
    "Did not find expected content" println
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
        doc := SGML parse(html)
        doc elementsWithTag("a") foreach(element,
            href := element attributes at("href")
            if(href, links append(href))
        )
        links
    )
    
    crawl := method(startUrl, maxDepth,
        visited := Map clone
        self crawlRecursive(startUrl, 1, maxDepth, visited)
        visited
    )
    
    crawlRecursive := method(url, depth, maxDepth, visited,
        if(depth > maxDepth, return)
        if(visited hasKey(url), return)
        
        visited atPut(url, true)
        
        html := self fetchUrl(url) 
        writeln("Crawling: ", url, " (depth: ", depth, ")")
        
        links := self extractLinks(html)
        links foreach(link,
            absoluteUrl := URL with(url) resolve(link)
            self crawlRecursive(absoluteUrl asString, depth + 1, maxDepth, visited)
        )
    )
)

// Example usage
crawler := WebCrawler clone
result := crawler crawl("https://example.com", 2)
writeln("Visited ", result size, " unique URLs")