
#!/usr/bin/env io

Url := Object clone do(
    fetch := method(url,
        request := URL with(url) fetch
        if(request isError, return nil)
        return request
    )
)

HtmlParser := Object clone do(
    extractLinks := method(html,
        links := List clone
        html findSeqIter("href=\"", 
            block(startIndex, endIndex,
                endQuote := html findSeq("\"", startIndex + 6)
                if(endQuote, 
                    link := html slice(startIndex + 6, endQuote)
                    links append(link)
                )
            )
        )
        return links
    )
    
    extractText := method(html,
        text := html asMutable
        text replaceSeq("<[^>]*>", "")
        text replaceSeq("\\s+", " ")
        return text strip
    )
)

Crawler := Object clone do(
    visitedUrls := Map clone
    
    crawl := method(url, depth,
        if(depth <= 0 or visitedUrls hasKey(url), return)
        
        visitedUrls atPut(url, true)
        
        content := Url fetch(url)
        if(content isNil, return)
        
        parser := HtmlParser clone
        links := parser extractLinks(content)
        text := parser extractText(content)
        
        writeln("URL: ", url)
        writeln("Title: ", text slice(0, 100), "...")
        writeln("Found ", links size, " links")
        writeln("---")
        
        links foreach(link,
            if(link beginsWithSeq("http"),
                Crawler crawl(link, depth - 1)
            )
        )
    )
)

if(isLaunchScript,
    Crawler crawl("http://example.com", 2)
)