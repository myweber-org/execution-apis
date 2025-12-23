
WebCrawler := Object clone do(
    fetchHtml := method(url,
        url asURL fetch
    )

    parseLinks := method(html,
        links := list()
        html findSeq("href=\"") repeat(
            start := html findSeq("href=\"") + 6
            end := html findSeq("\"", start)
            if(end, links append(html slice(start, end)))
        )
        links
    )

    crawl := method(url,
        html := self fetchHtml(url)
        links := self parseLinks(html)
        links foreach(link, link println)
    )
)

crawler := WebCrawler clone
crawler crawl("http://example.com")