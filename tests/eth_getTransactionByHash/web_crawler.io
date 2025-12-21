
WebCrawler := Object clone do(
    init := method(
        self url := nil
        self content := nil
    )

    setUrl := method(urlString,
        self url = urlString
        self
    )

    fetch := method(
        if(url == nil, return nil)
        try(
            self content = URL with(url) fetch
        ) catch(Exception,
            writeln("Failed to fetch URL: ", url)
            self content = nil
        )
        self
    )

    extractLinks := method(
        if(content == nil, return list())
        links := list()
        content split("\n") foreach(line,
            if(line containsSeq("href="),
                start := line findSeq("href=") + 6
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

    saveToFile := method(filename,
        if(content == nil, return false)
        file := File with(filename)
        file openForUpdating
        file write(content)
        file close
        true
    )
)

crawler := WebCrawler clone
crawler setUrl("https://example.com") fetch
links := crawler extractLinks
links foreach(link, writeln("Found link: ", link))
crawler saveToFile("example_content.html")