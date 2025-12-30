
WebCrawler := Object clone do(
    fetchHtml := method(url,
        urlObj := URL with(url)
        urlObj fetch
    )

    extractLinks := method(html,
        links := List clone
        html asMutable findSeq("href=\"") repeat(
            startPos := html findSeq("href=\"")
            if(startPos,
                html := html slice(startPos + 6)
                endPos := html findSeq("\"")
                if(endPos,
                    link := html slice(0, endPos)
                    if(link beginsWithSeq("http"),
                        links append(link)
                    )
                )
            )
        )
        links
    )

    crawl := method(startUrl, maxDepth := 2,
        visited := Map clone
        toVisit := List clone
        results := List clone

        toVisit append(list(startUrl, 1))

        while(toVisit size > 0,
            current := toVisit removeFirst
            url := current at(0)
            depth := current at(1)

            if(visited hasKey(url) not and depth <= maxDepth,
                visited atPut(url, true)
                writeln("Crawling: ", url, " at depth ", depth)

                html := fetchHtml(url)
                if(html,
                    links := extractLinks(html)
                    results append(list(url, links size))

                    if(depth < maxDepth,
                        links foreach(link,
                            toVisit append(list(link, depth + 1))
                        )
                    )
                )
            )
        )
        results
    )
)

// Example usage (commented out for production)
// crawler := WebCrawler clone
// results := crawler crawl("http://example.com", 1)
// results foreach(result, writeln("URL: ", result at(0), " - Links found: ", result at(1)))