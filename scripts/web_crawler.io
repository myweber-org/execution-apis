
#!/usr/local/bin/io

Url := Object clone do(
    fetch := method(url,
        page := URL with(url) fetch
        if(page isNil, return nil)
        return page
    )
)

HtmlParser := Object clone do(
    extractTitle := method(html,
        if(html isNil, return nil)
        startTag := html findSeq("<title>")
        endTag := html findSeq("</title>")
        if(startTag and endTag,
            return html slice(startTag + 7, endTag)
        )
        return nil
    )
)

Crawler := Object clone do(
    crawl := method(url,
        pageContent := Url fetch(url)
        title := HtmlParser extractTitle(pageContent)
        if(title,
            writeln("Title: ", title)
        ,
            writeln("Failed to fetch or parse title from: ", url)
        )
    )
)

Crawler crawl("http://example.com")