
WebCrawler := Object clone do(
    fetchHtml := method(url,
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
        html := fetchHtml(url)
        links := extractLinks(html)
        links
    )
)

// Example usage
crawler := WebCrawler clone
result := crawler crawl("http://example.com")
result foreach(link, link println)