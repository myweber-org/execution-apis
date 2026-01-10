
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

    crawl := method(startUrl, maxDepth,
        visited := Map clone
        queue := List clone
        queue append(list(startUrl, 0))
        results := List clone

        while(queue size > 0,
            current := queue removeFirst
            url := current at(0)
            depth := current at(1)

            if(visited at(url) == nil and depth <= maxDepth,
                visited atPut(url, true)
                writeln("Crawling: ", url, " at depth ", depth)

                html := self fetchHtml(url)
                if(html != nil,
                    links := self extractLinks(html)
                    results append(list(url, links))

                    if(depth < maxDepth,
                        links foreach(link,
                            queue append(list(link, depth + 1))
                        )
                    )
                )
            )
        )
        results
    )
)

// Example usage (commented out for production)
/*
crawler := WebCrawler clone
results := crawler crawl("http://example.com", 2)
results foreach(result,
    writeln("URL: ", result at(0))
    writeln("Found ", result at(1) size, " links")
    writeln("---")
)
*/