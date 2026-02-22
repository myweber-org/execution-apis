
WebCrawler := Object clone do(
    fetchHtml := method(url,
        url asURL fetch
    )

    extractLinks := method(html,
        links := List clone
        html findallSeq("href=\"(.*?)\"") foreach(match,
            links append(match at(1))
        )
        links
    )

    crawl := method(startUrl, maxDepth,
        visited := Map clone
        self _crawlRecursive(startUrl, 1, maxDepth, visited)
        visited
    )

    _crawlRecursive := method(url, depth, maxDepth, visited,
        if(depth > maxDepth, return)
        if(visited hasKey(url), return)

        html := self fetchHtml(url)
        visited atPut(url, html)

        links := self extractLinks(html)
        links foreach(link,
            self _crawlRecursive(link, depth + 1, maxDepth, visited)
        )
    )
)

// Example usage
crawler := WebCrawler clone
result := crawler crawl("http://example.com", 2)
result keys foreach(url,
    ("Fetched: " .. url) println
)