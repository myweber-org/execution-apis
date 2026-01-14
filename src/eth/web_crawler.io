
HttpRequest := Object clone do(
    withUrl := method(url,
        self clone setUrl(url)
    )
    
    url ::= nil
    
    fetch := method(
        if(url isNil, return nil)
        response := URL with(url) fetch
        return response
    )
)

HtmlParser := Object clone do(
    extractTitle := method(html,
        if(html isNil, return nil)
        startIndex := html findSeq("<title>")
        endIndex := html findSeq("</title>")
        if(startIndex and endIndex,
            return html slice(startIndex + 7, endIndex)
        )
        return nil
    )
)

WebCrawler := Object clone do(
    requestor := HttpRequest
    parser := HtmlParser
    
    crawl := method(url,
        response := requestor withUrl(url) fetch
        if(response isNil,
            writeln("Failed to fetch: ", url)
            return
        )
        title := parser extractTitle(response)
        if(title isNil,
            writeln("No title found for: ", url)
        ,
            writeln("Title: ", title)
        )
    )
)

crawler := WebCrawler clone
crawler crawl("http://example.com")
WebCrawler := Object clone do(
    fetchHtml := method(url,
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

    crawl := method(url, depth,
        if(depth <= 0, return)
        
        html := self fetchHtml(url)
        if(html == nil, return)
        
        writeln("Crawling: ", url)
        
        links := self extractLinks(html)
        links foreach(link,
            writeln("Found link: ", link)
            self crawl(link, depth - 1)
        )
    )
)

crawler := WebCrawler clone
crawler crawl("http://example.com", 2)