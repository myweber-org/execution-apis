
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
#!/usr/bin/env io

Url := Object clone do(
    with := method(url,
        self clone setUrl(url)
    )
    
    setUrl := method(url,
        self url := url
        self
    )
    
    fetch := method(
        System runCommand("curl -s \"#{url}\"" interpolate) output
    )
    
    extractTitle := method(html,
        titleMatch := html findSeq("<title>")
        if(titleMatch,
            start := titleMatch + 7
            end := html findSeq("</title>", start)
            if(end, html slice(start, end), "No title found")
        , "No title tag found")
    )
)

crawler := Url with("https://example.com")
html := crawler fetch
title := crawler extractTitle(html)
("Title: " .. title) println