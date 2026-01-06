
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