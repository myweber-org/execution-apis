
WebCrawler := Object clone do(
    fetch := method(url,
        request := URL with(url) fetch
        if(request isError,
            Exception raise("Failed to fetch URL: #{url}" interpolate)
        )
        request content
    )
    
    extractLinks := method(html,
        links := List clone
        html split("\n") foreach(line,
            line findSeq("href=\"") ifNonNil(pos,
                start := pos + 6
                end := line findSeq("\"", start)
                if(end, links append(line slice(start, end)))
            )
        )
        links
    )
    
    crawl := method(url,
        html := fetch(url)
        links := extractLinks(html)
        links map(link, if(link beginsWithSeq("/"), url .. link, link))
    )
)

crawler := WebCrawler clone
result := crawler crawl("https://example.com")
result join("\n") println