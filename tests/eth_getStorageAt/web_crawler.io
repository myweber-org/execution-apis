
WebCrawler := Object clone do(
    fetchUrl := method(url,
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

        while(queue size > 0,
            current := queue removeFirst
            url := current at(0)
            depth := current at(1)

            if(visited at(url) != true and depth <= maxDepth,
                visited atPut(url, true)
                writeln("Crawling: ", url, " at depth ", depth)

                html := fetchUrl(url)
                if(html != nil,
                    links := extractLinks(html)
                    writeln("Found ", links size, " links")

                    links foreach(link,
                        if(visited at(link) != true,
                            queue append(list(link, depth + 1))
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
urls := crawler crawl("https://example.com", 2)
writeln("Total URLs crawled: ", urls size)