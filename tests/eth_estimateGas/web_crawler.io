
WebCrawler := Object clone do(
    fetchUrl := method(url,
        urlObj := URL with(url)
        urlObj fetch
    )
    
    parseHtml := method(htmlString,
        parser := SGMLParser clone
        parser parse(htmlString)
        parser
    )
    
    extractLinks := method(parser,
        links := List clone
        parser tags foreach(tag,
            if(tag name == "a" and tag attributes at("href"),
                links append(tag attributes at("href"))
            )
        )
        links
    )
    
    crawl := method(url,
        html := fetchUrl(url)
        parser := parseHtml(html)
        links := extractLinks(parser)
        links
    )
)

crawler := WebCrawler clone
links := crawler crawl("http://example.com")
links foreach(link, link println)