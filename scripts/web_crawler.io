
WebCrawler := Object clone do(
    fetchUrl := method(url,
        urlObj := URL with(url)
        urlObj fetch
    )

    extractLinks := method(html,
        links := List clone
        html split("\n") foreach(line,
            if(line containsSeq("href="),
                start := line findSeq("href=") + 6
                end := line findSeq("\"", start)
                if(end, links append(line slice(start, end)))
            )
        )
        links
    )

    crawl := method(url,
        html := fetchUrl(url)
        if(html,
            links := extractLinks(html)
            links foreach(link, writeln("Found link: ", link))
            links
        ,
            writeln("Failed to fetch URL: ", url)
            nil
        )
    )
)

// Example usage
crawler := WebCrawler clone
crawler crawl("http://example.com")